import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kazana/models/place.dart';
import 'package:kazana/providers/user_places.dart';
import 'package:kazana/widgets/image_input.dart';
import 'package:kazana/widgets/location_input.dart';

// Define a screen for adding a new place, which extends ConsumerStatefulWidget.
class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  // Controller for the title input field.
  final _titleController = TextEditingController();

  // Store the selected image and location.
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  // Function to save the new place to the user's places.
  void _savePlace() {
    final enteredTitle = _titleController.text;

    // Check if the entered title, image, and location are not empty.
    if (enteredTitle.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      return;
    }

    // Use Riverpod to add the new place to the user's places.
    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredTitle, _selectedImage!, _selectedLocation!);

    // Close the screen and return to the previous screen.
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Title input field.
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),

            // Image Input widget for capturing or selecting an image.
            const SizedBox(height: 10),
            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(height: 16),

            // Location Input widget for selecting a place on the map.
            LocationInput(
              onSelectLocation: (location) {
                _selectedLocation = location;
              },
            ),
            const SizedBox(height: 16),

            // Button to save the new place.
            ElevatedButton.icon(
              onPressed: _savePlace,
              label: const Text('Add Place'),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
