import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kazana/models/place.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(String title, File image, PlaceLocation location) {
    final
    final newPlace = Place(title: title, image: image, location: location);
    state = [newPlace, ...state]; // new place getting added to the beginning
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
        (ref) => UserPlacesNotifier());
