import 'dart:convert';
import 'dart:io';

import 'package:favorite_places/controller/favorite_places_controller.dart';
import 'package:favorite_places/controller/location_controller.dart';
import 'package:favorite_places/controller/new_places_controller.dart';
import 'package:favorite_places/models/http/favorite_place_http_model.dart';
import 'package:favorite_places/models/http/location_http_model.dart';
import 'package:favorite_places/widgets/alternative/location_input_http.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';

class AddFavPlaceView extends StatefulWidget {
   AddFavPlaceView(
      {super.key,
      required this.newPlacesController,
      required this.favoritePlacesController,
      required this.pickedLocation,
      required this.locationController});

  final NewPlacesController newPlacesController;
  final FavoritePlacesController favoritePlacesController;
  LocationHttpModel? pickedLocation;
  final LocationController locationController;

  @override
  State<AddFavPlaceView> createState() => _AddFavPlaceViewState();
}

class _AddFavPlaceViewState extends State<AddFavPlaceView> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  File? _selectedImage;

  Future<void> _saveItem() async {
    final response = await widget.favoritePlacesController.getUrl();

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (widget.pickedLocation == null) {
        // Lokasi belum dipilih, berikan pesan kesalahan
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a location'),
          ),
        );
        return;
      }
      await widget.newPlacesController.saveItem(
          image: _selectedImage!.path,
          name: _enteredName,
          location: widget.pickedLocation!);

      final items = await widget.favoritePlacesController.loadItem();
      setState(() {
        widget.newPlacesController.favoritePlacesModel = items;
      });

      if (!context.mounted) return;

      final jsonData = json.decode(response.body);
      final firstItem = jsonData.first;
      final placesId = firstItem['placesId'];

      Navigator.pop(
          context,
          FavoritePlacesHttpModel(
              name: _enteredName,
              id: placesId,
              image: File(_selectedImage!.path),
              location: widget.pickedLocation!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add new favorite place'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                minLines: 1,
                maxLines: 3,
                decoration: const InputDecoration(
                  label: Text('name'),
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value == '' ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 1 and 50 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              const SizedBox(height: 20),
              ImageInput(
                onPickImage: (image) {
                  _selectedImage = image;
                },
              ),
              const SizedBox(height: 20),
              LocationInputHttp(
                onSelectLocation: (location) {
                  location.id;
                  widget.pickedLocation = location;
                },
                locationController: widget.locationController,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: _saveItem,
                    icon: const Icon(Icons.add),
                    label: const Text(
                      'add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
