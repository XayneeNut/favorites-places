import 'dart:convert';

import 'package:favorite_places/models/favorite_place_http_model.dart';
import 'package:favorite_places/models/location_http_model.dart';
import 'package:http/http.dart' as http;

class NewPlacesController {
  List<FavoritePlacesHttpModel> favoritePlacesModel = [];
  var enteredName = '';
  var image = '';

  Future<void> saveItem({
    required String image,
    required String name,
    required LocationHttpModel location,
  }) async {
    final url = Uri.parse('http://10.0.2.2:8124/api/v1/places/create');

    final body = json.encode({
      'name': name,
      'image': image,
      'locationId': location.id,
    });

    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: body);

      if (response.statusCode == 400) {
        throw Exception('Failed to save item');
      } else {
        throw Exception('Failed to save item');
      }
    } catch (e) {
      //handling eror message
    }
  }
}
