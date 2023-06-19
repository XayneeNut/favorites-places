import 'package:favorite_places/models/http/location_http_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapViewHttp extends StatefulWidget {
  const MapViewHttp(
      {super.key,
      this.locationModel = const LocationHttpModel(
          id: 1,
          latitude: -6.228951,
          longitude: 106.812859,
          formattedAddress: ''),
      this.isSelecting = true});

  final LocationHttpModel locationModel;
  final bool isSelecting;

  @override
  State<MapViewHttp> createState() => _MapViewHttpState();
}

class _MapViewHttpState extends State<MapViewHttp> {
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
