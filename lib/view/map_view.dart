import 'package:favorite_places/models/location_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  const MapView(
      {super.key,
      this.locationModel = const LocationModel(
          latitude: -6.228951, longitude: 106.812859, formatedAddress: ''),
      this.isSelecting = true});

  final LocationModel locationModel;
  final bool isSelecting;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting ? 'Pick Location' : 'Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                Navigator.pop(context, _pickedLocation);
              },
              icon: const Icon(Icons.save),
            ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          onTap: !widget.isSelecting
              ? null
              : (tapPosition, point) {
                  setState(() {
                    _pickedLocation = point;
                  });
                },
          center: LatLng(
            widget.locationModel.latitude,
            widget.locationModel.longitude,
          ),
          zoom: 16,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://maps.geoapify.com/v1/tile/carto/{z}/{x}/{y}.png?&apiKey=c46b883adce04dcd9c70cfda39c9dd15',
          ),
          MarkerLayer(
            markers: (_pickedLocation == null && widget.isSelecting)
                ? []
                : [
                    Marker(
                      point: _pickedLocation ??
                          LatLng(
                            widget.locationModel.latitude,
                            widget.locationModel.longitude,
                          ),
                      builder: (ctx) => const Icon(Icons.location_on,
                          color: Colors.red, size: 30),
                    ),
                  ],
          ),
        ],
      ),
    );
  }
}
