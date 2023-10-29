import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  // Callback function that will be called when an image is picked
  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() {
    return _ImageInput();
  }
}

class _ImageInput extends State<ImageInput> {
  // Holds the selected image file
  File? _selectedImage;

  // Function to take a picture using the device's camera
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    // If no image is picked, return
    if (pickedImage == null) {
      return;
    }

    // Update the selectedImage with the picked image
    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    // Call the callback function with the selected image
    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    // Define the default content as a 'Take picture' button
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      icon: const Icon(Icons.camera),
      label: const Text('Take picture'),
    );

    // If an image is selected, display the selected image
    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
      );
    }

    // Container for displaying the camera button or selected image
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
