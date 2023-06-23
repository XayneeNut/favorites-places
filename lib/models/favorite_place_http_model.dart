import 'dart:io';

import 'package:favorite_places/models/location_http_model.dart';

class FavoritePlacesHttpModel {
  const FavoritePlacesHttpModel(
      {required this.name,
      required this.id,
      required this.image,
      required this.location});

  final String id;
  final String name;
  final File image;
  final LocationHttpModel location;

  factory FavoritePlacesHttpModel.fromJson(Map<String, dynamic> json) {
    return FavoritePlacesHttpModel(
      name: json['name'],
      id: json['placesId'],
      image: json['image'],
      location: LocationHttpModel(
        latitude: json['locationId']['latitude'],
        id: json['locationId']['locationId'],
        longitude: json['locationId']['longitude'],
        formattedAddress: json['locationId']['formattedAddress'],
      ),
    );
  }
}
