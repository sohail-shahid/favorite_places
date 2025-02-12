import 'package:flutter/material.dart';
import 'package:favorite_places/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocationModel locationModel;
  final bool isSelecting;
  const MapScreen({
    super.key,
    this.locationModel = const PlaceLocationModel(
      lat: 37.422,
      long: -122.084,
      name: 'My home',
    ),
    this.isSelecting = true,
  });

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  LatLng? pickedLocation;
  @override
  Widget build(BuildContext context) {
    final String title =
        widget.isSelecting ? "Pick a location" : 'Your location';
    final latLng = LatLng(widget.locationModel.lat, widget.locationModel.long);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(pickedLocation);
              },
              icon: const Icon(Icons.save),
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: latLng,
          zoom: 16,
        ),
        onTap: !widget.isSelecting
            ? null
            : (position) => {
                  setState(() {
                    pickedLocation = position;
                  })
                },
        markers: (pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: pickedLocation ?? latLng,
                )
              },
      ),
    );
  }
}
