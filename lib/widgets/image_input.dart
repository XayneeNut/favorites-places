import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takeImage() async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 600,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takeImage,
      icon: const Icon(Icons.camera),
      label: const Text('Take Picture'),
    );

    if (_selectedImage != null) {
      content = Image.file(
        _selectedImage!,
        fit: BoxFit.cover,
  
      );
    }

    return Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70),
          color: const Color.fromRGBO(46, 34, 48, 1),
        ),
        child: content);
  }
}
