import 'dart:convert';

import 'package:favorite_places/controller/location_controller.dart';
import 'package:favorite_places/models/location_http_model.dart';
import 'package:favorite_places/view/map_view_http.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInputHttp extends StatefulWidget {
  const LocationInputHttp(
      {super.key,
      required this.onSelectLocation,
      required this.locationController});

  final void Function(LocationHttpModel locationModel) onSelectLocation;
  final LocationController locationController;

  @override
  State<LocationInputHttp> createState() => _LocationInputHttpState();
}

class _LocationInputHttpState extends State<LocationInputHttp> {
  LocationHttpModel? _pickLocation;
  var _isGettingLocation = false;

  String get locationImage {
    if (_pickLocation == null) {
      return '';
    }
    final lat = _pickLocation!.latitude;
    final long = _pickLocation!.longitude;

    return 'https://maps.geoapify.com/v1/staticmap?style=osm-carto&width=600&height=300&center=lonlat:$long,$lat&zoom=14&marker=lonlat:$long,$lat;color:%23ff0000;size:medium|lonlat:$long,$lat;color:%23ff0000;size:medium&apiKey=c46b883adce04dcd9c70cfda39c9dd15';
  }

  Future<void> _savePlace(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://geocode.maps.co/reverse?lat=$latitude&lon=$longitude');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    final address = resData['display_name'];

    try {
      final createdLocation = await widget.locationController.saveData(
          latitude: latitude, longitude: longitude, formatedAddress: address);

      setState(
        () {
          _pickLocation = createdLocation;
        },
      );

      widget.onSelectLocation(_pickLocation!);
    } catch (e) {}
  }

  void _getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    try {
      locationData = await location.getLocation();
      final lat = locationData.latitude;
      final long = locationData.longitude;

      if (lat == null || long == null) {
        throw Exception('Failed to get current location');
      }

      await _savePlace(lat, long);

      setState(() {
        _isGettingLocation = false;
      });
    } catch (e) {
      // Handle error message
    }
  }

  void _selectOnMap() async {
    final pickedLocation = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(
        builder: (context) => const MapViewHttp(),
      ),
    );

    if (pickedLocation == null) {
      return;
    }

    setState(() {
      _isGettingLocation = true;
    });

    _savePlace(pickedLocation.latitude, pickedLocation.longitude);

    setState(() {
        _isGettingLocation = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No Location Choosen',
      textAlign: TextAlign.center,
      style:
          Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
    );

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    if (_pickLocation != null) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      );
    }

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.2))),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Get current Location'),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
            ),
          ],
        ),
      ],
    );
  }
}
