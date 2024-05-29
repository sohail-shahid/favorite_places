import 'dart:io';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
const apiKey = 'API_Key';

class PlaceLocationModel {
  const PlaceLocationModel({
    required this.lat,
    required this.long,
    required this.name,
  });
  final double lat;
  final double long;
  final String name;

  String get locationImage {
    return 'https://maps.googleapis.com/maps/api/staticmap?center$lat,$long=&zoom=12&size=300x600&maptype=roadmap&markers=$lat,$long&key=$apiKey';
  }
}

class PlaceModel {
  PlaceModel({
    required this.name,
    required this.image,
    required this.locationModel,
    String? id,
  }) : id = id ?? uuid.v4();
  final String id;
  final String name;
  File image;
  final PlaceLocationModel locationModel;
}
