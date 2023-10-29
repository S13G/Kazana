import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kazana/providers/user_places.dart';
import 'package:kazana/screens/add_place.dart';
import 'package:kazana/widgets/places_list.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlacesScreen();
  }
}

class _PlacesScreen extends ConsumerState<PlacesScreen> {
  late Future<void> _placesFuture; // Initialize a future for loading user places

  @override
  void initState() {
    super.initState();

    // Load user places when the screen is initialized
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider); // Read user places from the provider

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          // Add button to navigate to the AddPlaceScreen
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddPlaceScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _placesFuture,
          builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : PlacesList(places: userPlaces), // Display user places using PlacesList widget
        ),
      ),
    );
  }
}
