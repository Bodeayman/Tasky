import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/core/utils/style/colors.dart';

class AddTaskButton extends StatefulWidget {
  const AddTaskButton({super.key});

  @override
  State<AddTaskButton> createState() => _AddTaskButtonState();
}

class _AddTaskButtonState extends State<AddTaskButton> {
  File? _image;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      uploadFile(_image!);
    }
  }

  Future<void> uploadFile(File file) async {
    final uri = Uri.parse('https://your-api-endpoint.com/upload');
    var request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath(
      'file', // name expected by server
      file.path,
      contentType: MediaType('image', 'jpeg'), // adjust based on file type
    ));

    final response = await request.send();

    if (response.statusCode == 200) {
      debugPrint('Upload successful');
    } else {
      debugPrint('Upload failed: ${response.statusCode}');
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 56,
                child: (_image != null)
                    ? Image.file(_image!, fit: BoxFit.cover)
                    : const Icon(Icons.image, size: 30),
              ),
              const SizedBox(width: 10),
              const SizedBox(width: 10),
              Text(
                "Add Img",
                style: TextStyle(color: mainColor, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
