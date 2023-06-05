import 'dart:io';

class FavoritePlaceModel {
  const FavoritePlaceModel({required this.name, required this.id, required this.image});

  final int id;
  final String name;
  final File image;
}
