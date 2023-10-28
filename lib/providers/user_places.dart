import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kazana/models/place.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(String title) {
    final newPlace = Place(title: title);
    state = [newPlace, ...state]; // new place getting added to the beginning
  }
}

final userPlacesProvider = StateNotifierProvider((ref) => UserPlacesNotifier());
