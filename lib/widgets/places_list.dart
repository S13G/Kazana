import 'package:flutter/material.dart';
import 'package:kazana/models/place.dart';
import 'package:kazana/screens/place_detail.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({
    super.key,
    required this.places,
  });

  final List<Place> places; // List of Place objects to display

  @override
  Widget build(BuildContext context) {
    // Check if the list of places is empty
    if (places.isEmpty) {
      return Center(
        child: Text(
          'No places added yet', // Message displayed when there are no places
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }

    // Display a list of places using a ListView builder
    return ListView.builder(
      itemCount: places.length,
      // Create a list item for each place
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: FileImage(places[index].image), // Display place's image
        ),
        title: Text(
          places[index].title, // Display place's title
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        subtitle: Text(
          places[index].location.address, // Display place's address
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        // Navigate to the PlaceDetailScreen when the list item is tapped
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PlaceDetailScreen(place: places[index]),
            ),
          );
        },
      ),
    );
  }
}
