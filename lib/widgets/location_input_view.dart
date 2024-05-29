import 'dart:convert';
import 'package:favorite_places/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:favorite_places/models/place_model.dart';

class LocationInputView extends StatefulWidget {
  const LocationInputView({super.key, required this.onLocationSelected});
  final void Function(PlaceLocationModel) onLocationSelected;

  @override
  State<LocationInputView> createState() {
    return _LocationInputViewState();
  }
}

class _LocationInputViewState extends State<LocationInputView> {
  PlaceLocationModel? _locationModel;
  bool _isPickingLocation = false;

  Future<void> _savePlace(double lat, double long) async {
    setState(() {
      _isPickingLocation = true;
    });

    print(lat);
    print(long);
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$apiKey');
    print(url);
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    print(responseData);

    final address = responseData['results'][0]['formatted_address'];
    setState(() {
      _locationModel = PlaceLocationModel(lat: lat, long: long, name: address);
      _isPickingLocation = false;
    });
    widget.onLocationSelected(_locationModel!);
  }

  void _onGetCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

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
    LocationData locationData = await location.getLocation();
    final lat = locationData.latitude ?? 0.0;
    final long = locationData.longitude ?? 0.0;
    _savePlace(lat, long);
  }

  void _onSelectLocationOnMap() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (conxt) => const MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (pickedLocation == null) {
      return;
    }
    _savePlace(pickedLocation.latitude, pickedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget containerChild = const Text(
      'No location choosen',
      textAlign: TextAlign.center,
    );
    if (_locationModel != null) {
      containerChild = Image.network(_locationModel!.locationImage);
    }
    if (_isPickingLocation) {
      containerChild = const CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          child: containerChild,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _onGetCurrentLocation,
              label: const Text('Get current location'),
              icon: const Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: _onSelectLocationOnMap,
              label: const Text('Select on map'),
              icon: const Icon(Icons.map),
            ),
          ],
        ),
      ],
    );
  }
}
