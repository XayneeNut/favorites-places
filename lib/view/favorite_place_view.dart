import 'package:favorite_places/models/favorite_place_model.dart';
import 'package:flutter/material.dart';

class FavoritePlaceView extends StatelessWidget {
  const FavoritePlaceView({super.key, required this.favoritePlaceModel});
  final FavoritePlaceModel favoritePlaceModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(favoritePlaceModel.name),
      ),
      body: const Center(
        child: Text(
          'ini adalah favorite place',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
