import 'dart:io';

import 'package:favorite_places/generator/random_int_id.dart';
import 'package:favorite_places/models/favorite_place_model.dart';
import 'package:favorite_places/models/location_model.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';

class AddFavPlaceView extends StatefulWidget {
  const AddFavPlaceView({super.key});

  @override
  State<AddFavPlaceView> createState() => _AddFavPlaceViewState();
}

class _AddFavPlaceViewState extends State<AddFavPlaceView> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  final _id = RandomIntId().gusantaIdGen();
  File? _selectedImage;
  LocationModel? _selectedLocation;

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    var newItem = FavoritePlaceModel(
      name: _enteredName,
      id: _id,
      image: _selectedImage!,
      location: _selectedLocation!
    );
    Navigator.pop(context, newItem);
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
