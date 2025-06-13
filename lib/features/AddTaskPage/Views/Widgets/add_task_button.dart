import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/core/utils/refresh_token.dart';
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/core/utils/url.dart';
import 'package:tasky/features/AddTaskPage/Manager/adding_task_cubit.dart';

class AddTaskButton extends StatefulWidget {
  const AddTaskButton({super.key});
  @override
  State<AddTaskButton> createState() => _AddTaskButtonState();
}

class _AddTaskButtonState extends State<AddTaskButton> {
  File? _image;
  bool stillUploaded = false;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      context.read<AddingTaskCubit>().addingImage();
      stillUploaded = true;

      setState(() {
        _image = File(pickedFile.path);
      });

      await uploadFile(_image!);
      stillUploaded = false;
      setState(() {});
      context.read<AddingTaskCubit>().finishedUploadingImages();
    }
  }

  Future<String?> uploadFile(File file) async {
    try {
      final token = await getAccessToken();
      final uri = Uri.parse('$baseUrl/upload/image');

      var request = http.MultipartRequest('POST', uri);

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      request.files.add(await http.MultipartFile.fromPath(
        'image', // Use the correct field name expected by your backend
        file.path,
        contentType: MediaType('image', 'jpeg'),
      ));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201 || response.statusCode == 200) {
        debugPrint('Upload successful: $responseBody');

        final data = jsonDecode(responseBody);
        final filename = data['image'];
        final imageUrl = '$baseUrl/uploads/$filename';

        debugPrint('Full image URL: $imageUrl');
        context.read<AddingTaskCubit>().setImagePath(filename);
        debugPrint(filename);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The image is uploaded successfully"),
          ),
        );
        return imageUrl;
      } else {
        return null;
      }
    } catch (e) {
      await refreshAccessToken();
      debugPrint('Exception: ${e.toString()}');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: mainColor,
      strokeWidth: 1,
      dashPattern: const [6, 3],
      borderType: BorderType.RRect,
      radius: const Radius.circular(kborderSize),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kborderSize),
        child: OutlinedButton(
          onPressed: pickImage,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            side: BorderSide.none, // Remove solid border
            backgroundColor: Colors.transparent,
          ),
          child: (_image == null)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 56,
                      child: Icon(
                        Icons.image,
                        size: 30,
                        color: mainColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const SizedBox(width: 10),
                    Text(
                      "Add Img",
                      style: TextStyle(color: mainColor, fontSize: 18),
                    ),
                  ],
                )
              : SizedBox(
                  width: double.infinity,
                  height: 160,
                  child: Opacity(
                    opacity: stillUploaded ? 0.5 : 1.0,
                    child: Image.file(
                      _image!,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
