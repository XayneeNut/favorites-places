import 'dart:convert';

import 'package:favorite_places/models/http/location_http_model.dart';
import 'package:http/http.dart' as http;

class LocationController {
  Future<http.Response> getAllUrl() async {
    final url = Uri.parse('http://10.0.2.2/api/v1/location/get-all');
    final response = await http.get(url);
    return response;
  }

  Future<http.Response> getFormatedMap(
      double latitude, double longitude) async {
    final url = Uri.parse(
        'https://geocode.maps.co/reverse?lat=$latitude&lon=$longitude');
    final response = await http.get(url);
    return response;
  }

  Future<LocationHttpModel> saveData(
      {required latitude, required longitude, required formatedAddress}) async {
    final url = Uri.parse('http://10.0.2.2:8124/api/v1/location/create');
    final body = json.encode({
      'latitude': latitude,
      'longitude': longitude,
      'formattedAddress': formatedAddress
    });

      try {
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final locationId = jsonData['locationId'];
      return LocationHttpModel(
        id: locationId,
        latitude: latitude,
        longitude: longitude,
        formattedAddress: formatedAddress,
      );
    } else {
      throw Exception('Failed to save location');
    }
  } catch (e) {
    print('Error: ${e.toString()}');
    print('Response: ${e is http.Response ? e.body : 'Unknown'}');
    throw Exception('Failed to save location');
  }
}

  Future<LocationHttpModel> loadData(int id) async {
    final url = Uri.parse('http://10.0.2.2:8124/api/v1/location/get/$id');
    final response = await http.get(url);
    final jsonData = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception('Failed to load data');
    }

    final locationData = jsonData['data'];

    final locationId = locationData['locationId'];
    final latitude = locationData['latitude'];
    final longitude = locationData['longitude'];
    final formattedAddress = locationData['formattedAddress'];

    final locationHttpModel = LocationHttpModel(
      latitude: latitude,
      id: locationId,
      longitude: longitude,
      formattedAddress: formattedAddress,
    );

    return locationHttpModel;
  }
}
