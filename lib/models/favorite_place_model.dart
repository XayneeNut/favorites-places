import 'dart:io';

import 'package:favorite_places/models/location_model.dart';

class FavoritePlaceModel {
  const FavoritePlaceModel(
      {required this.name, required this.id, required this.image, required this.location});

  final int id;
  final String name;
  final File image;
  final LocationModel location;
}
