import 'package:favorite_places/controller/favorite_places_controller.dart';
import 'package:favorite_places/controller/location_controller.dart';
import 'package:favorite_places/controller/new_places_controller.dart';
import 'package:favorite_places/models/http/favorite_place_http_model.dart';
import 'package:favorite_places/models/http/location_http_model.dart';
import 'package:favorite_places/view/add_favplace_view.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';

class HomeFavPlaceView extends StatefulWidget {
  const HomeFavPlaceView({super.key});

  @override
  State<HomeFavPlaceView> createState() => _HomeFavPlaceViewState();
}

class _HomeFavPlaceViewState extends State<HomeFavPlaceView> {
  final List<FavoritePlacesHttpModel> _favoritePlaces = [];
  final FavoritePlacesController _favoritePlacesController =
      FavoritePlacesController();
  final NewPlacesController _newPlacesController = NewPlacesController();
  LocationHttpModel? _pickedLocation;
  final LocationController _locationController = LocationController();

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  void _onAddIcon() async {
    final newItem = await Navigator.push<FavoritePlacesHttpModel>(
      context,
      MaterialPageRoute(
        builder: (ctx) => AddFavPlaceView(
            favoritePlacesController: _favoritePlacesController,
            newPlacesController: _newPlacesController,
            pickedLocation: _pickedLocation,
            locationController: _locationController,),
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

  void _loadItem() async {
    List<FavoritePlacesHttpModel> favoritePlacesData =
        await _favoritePlacesController.loadItem();

    setState(() {
      _favoritePlaces.clear();
      _favoritePlaces.addAll(favoritePlacesData);
    });
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
        body: PlacesList(places: _favoritePlaces));
  }
}
