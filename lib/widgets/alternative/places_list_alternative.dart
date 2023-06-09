import 'package:favorite_places/models/favorite_place_model.dart';
import 'package:favorite_places/view/favorite_place_view.dart';
import 'package:flutter/material.dart';

class PlacesListAlternative extends StatelessWidget {
  const PlacesListAlternative({super.key, required this.places});

  final List<FavoritePlaceModel> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'no places added now',
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }
    return Scaffold(
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: FileImage(places[index].image),
          ),
          title: Text(
            places[index].name,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
          ),
          subtitle: Text(
            places[index].location.formatedAddress,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white),
            ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) =>
                    FavoritePlaceView(favoritePlaceModel: places[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
