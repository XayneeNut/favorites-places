import 'dart:convert';
import 'dart:io';

import 'package:favorite_places/models/http/favorite_place_http_model.dart';
import 'package:favorite_places/models/http/location_http_model.dart';
import 'package:http/http.dart' as http;

class FavoritePlacesController {
  Future<http.Response> getUrl() async {
    final url = Uri.parse('http://10.0.2.2:8124/api/v1/places/get-all');
    final response = await http.get(url);
    return response;
  }

  Future<List<FavoritePlacesHttpModel>> loadItem() async {
    final url = Uri.parse('http://10.0.2.2:8124/api/v1/places/get-all');

    final response = await http.get(url);
    final jsonData = json.decode(response.body);

    List<FavoritePlacesHttpModel> favoritePlacesModel = [];

    for (var favoritePlacesHttpModel in jsonData) {
      final favoritePlaceId = favoritePlacesHttpModel['placesId'];
      final name = favoritePlacesHttpModel['name'];
      final image = favoritePlacesHttpModel['image'];
      final locationId = favoritePlacesHttpModel['locationId']['locationId'];
      final latitude = favoritePlacesHttpModel['locationId']['latitude'];
      final longitude = favoritePlacesHttpModel['locationId']['longitude'];
      final formattedAddress =
          favoritePlacesHttpModel['locationId']['formattedAddress'];

      final favoritePlaces = FavoritePlacesHttpModel(
        name: name,
        id: favoritePlaceId,
        image: File(image as String),
        location: LocationHttpModel(
            latitude: latitude,
            id: locationId,
            longitude: longitude,
            formattedAddress: formattedAddress),
      );
      favoritePlacesModel.add(favoritePlaces);
    }
    return favoritePlacesModel;
  }

  Future<http.Response> deleteData(FavoritePlacesHttpModel favoritePlaceHttpModel) {
    final deleteUrl = Uri.parse(
        'http://10.0.2.2:8124/api/v1/places/delete/${favoritePlaceHttpModel.id}');
    final deleteItem = http.delete(deleteUrl);
    return deleteItem;
  }
}
