import 'dart:io';

import 'package:favorite_places/models/http/location_http_model.dart';

class FavoritePlacesHttpModel {
  const FavoritePlacesHttpModel(
      {required this.name, required this.id, required this.image, required this.location});

  final int id;
  final String name;
  final File image;
  final LocationHttpModel location;
}
