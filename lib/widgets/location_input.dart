import 'dart:convert';

import 'package:favorite_places/models/location_model.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});

  final void Function(LocationModel locationModel) onSelectLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LocationModel? _pickLocation;
  var _isGettingLocation = false;

  String get locationImage {
    if (_pickLocation == null) {
      return '';
    }
    final lat = _pickLocation!.latitude;
    final long = _pickLocation!.longitude;

    return 'https://maps.geoapify.com/v1/staticmap?style=osm-carto&width=600&height=300&center=lonlat:$long,$lat&zoom=14&marker=lonlat:$long,$lat;color:%23ff0000;size:medium|lonlat:$long,$lat;color:%23ff0000;size:medium&apiKey=c46b883adce04dcd9c70cfda39c9dd15';
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

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final long = locationData.longitude;

    if (lat == null || long == null) {
      return;
    }

    final url = Uri.parse('https://geocode.maps.co/reverse?lat=$lat&lon=$long');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    final address = resData['display_name'];

    setState(
      () {
        _pickLocation = LocationModel(
            latitude: lat, longitude: long, formatedAddress: address);
        _isGettingLocation = false;
      },
    );

    widget.onSelectLocation(_pickLocation!);
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
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('Get current Location'),
            ),
          ],
        ),
      ],
    );
  }
}
