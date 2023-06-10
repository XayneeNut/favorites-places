import 'package:favorite_places/generator/getters.dart';
import 'package:favorite_places/models/favorite_place_model.dart';
import 'package:favorite_places/view/map_view.dart';
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
      body: Stack(
        children: [
          Image.file(
            favoritePlaceModel.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => MapView(
                          locationModel: favoritePlaceModel.location,
                          isSelecting: false,
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage:
                        NetworkImage(Getters(favoritePlaceModel).locationImage),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    gradient: const LinearGradient(
                        colors: [Colors.transparent, Colors.black54],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                  child: Text(
                    favoritePlaceModel.location.formatedAddress,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
