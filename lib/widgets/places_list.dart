import 'package:favorite_places/controller/favorite_places_controller.dart';
import 'package:favorite_places/models/http/favorite_place_http_model.dart';
import 'package:favorite_places/view/alternative/favorite_place_http.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatefulWidget {
  const PlacesList({super.key, required this.places});

  final List<FavoritePlacesHttpModel> places;

  @override
  State<PlacesList> createState() => _PlacesListState();
}

class _PlacesListState extends State<PlacesList> {
  final FavoritePlacesController _favoritePlacesController =
      FavoritePlacesController();

  void _onSelectFavoritePlace(int index) {
    if (widget.places.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FavoritePlaceHttp(
            favoritePlaceModel: widget.places[index],
          ),
        ),
      );
    }
  }

  void _deleteData(FavoritePlacesHttpModel favoritePlacesHttpModel) async {
    final response =
        await _favoritePlacesController.deleteData(favoritePlacesHttpModel);
    final index = widget.places.indexOf(favoritePlacesHttpModel);

    setState(() {
      widget.places.remove(favoritePlacesHttpModel);
    });

    await _favoritePlacesController.deleteData(favoritePlacesHttpModel);

    if (response.statusCode >= 400) {
      setState(() {
        widget.places.insert(index, favoritePlacesHttpModel);
      });
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
          _deleteData(widget.places[index]);
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
            widget.places[index].location.formattedAddress,
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
