import 'package:favorite_places/generator/random_int_id.dart';
import 'package:favorite_places/models/favorite_place_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlaceNotifier extends StateNotifier<List<FavoritePlaceModel>> {
  UserPlaceNotifier() : super(const []);

  void addPlace(String title) {
    final newPlace = FavoritePlaceModel(
      name: title,
      id: RandomIntId().gusantaIdGen(),
    );
    state = [newPlace, ...state];
  }
}

final userPlaceProvider = StateNotifierProvider((ref) => UserPlaceNotifier(),);
