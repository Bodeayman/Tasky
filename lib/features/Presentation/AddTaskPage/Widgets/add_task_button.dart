import 'dart:io';

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
      print('Upload successful');
    } else {
      print('Upload failed: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kborderSize),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          side: BorderSide(style: BorderStyle.solid, color: mainColor),
        ),
        onPressed: pickImage,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: (_image != null)
                  ? Image.file(_image!)
                  : Image.asset("assets/groceryHuge.png"),
            ),
            Icon(Icons.photo, color: mainColor, size: 35),
            Container(width: 20),
            Text(
              "Add Img",
              style: TextStyle(color: mainColor, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
