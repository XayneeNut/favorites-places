import 'package:favorite_places/models/favorite_place_model.dart';
import 'package:favorite_places/view/add_favplace_view.dart';
import 'package:favorite_places/view/favorite_place_view.dart';
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

  void _onSelectFavoritePlace(int index) {
    if (_favoritePlaces.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FavoritePlaceView(
            favoritePlaceModel: _favoritePlaces[index],
          ),
        ),
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
      body: ListView.builder(
        itemCount: _favoritePlaces.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            setState(
              () {
                _favoritePlaces.removeAt(index);
              },
            );
          },
           key: ValueKey(_favoritePlaces[index].id),
          child: ListTile(
            title: Text(
              _favoritePlaces[index].name,
              style: const TextStyle(color: Colors.white),
            ),
            onTap: () => _onSelectFavoritePlace(index),
          ),
        ),
      ),
    );
  }
}
