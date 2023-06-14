import 'package:favorite_places/models/favorite_place_model.dart';
import 'package:favorite_places/view/add_favplace_view.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';

class HomeFavPlaceView extends StatefulWidget {
  const HomeFavPlaceView({super.key});

  @override
  State<HomeFavPlaceView> createState() => _HomeFavPlaceViewState();
}

class _HomeFavPlaceViewState extends State<HomeFavPlaceView> {
  final List<FavoritePlaceModel> _favoritePlaces = [];

  void _onAddIcon() async {
    final newItem = await Navigator.push<FavoritePlaceModel>(
      context,
      MaterialPageRoute(
        builder: (ctx) => const AddFavPlaceView(),
      ),
    );

    if (newItem != null) {
      setState(
        () {
          _favoritePlaces.add(newItem);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('favorite places'),
        actions: [
          IconButton(
            onPressed: _onAddIcon,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: PlacesList(places: _favoritePlaces)
    );
  }
}
