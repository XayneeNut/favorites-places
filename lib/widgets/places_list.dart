import 'package:favorite_places/models/favorite_place_model.dart';
import 'package:favorite_places/view/favorite_place_view.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatefulWidget {
  const PlacesList({super.key, required this.places});

  final List<FavoritePlaceModel> places;

  @override
  State<PlacesList> createState() => _PlacesListState();
}

class _PlacesListState extends State<PlacesList> {
  void _onSelectFavoritePlace(int index) {
    if (widget.places.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FavoritePlaceView(
            favoritePlaceModel: widget.places[index],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.places.isEmpty) {
      return Center(
        child: Text(
          'no places added now',
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }
    return ListView.builder(
      itemCount: widget.places.length,
      itemBuilder: (ctx, index) => Dismissible(
        onDismissed: (direction) {
          setState(
            () {
              widget.places.removeAt(index);
            },
          );
        },
        key: ValueKey(widget.places[index].id),
        child: ListTile(
          title: Text(
            widget.places[index].name,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
          subtitle: Text(
            widget.places[index].location.formatedAddress,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white),
          ),
          onTap: () => _onSelectFavoritePlace(index),
          leading: CircleAvatar(
              radius: 23,
              backgroundImage: FileImage(widget.places[index].image)),
        ),
      ),
    );
  }
}
