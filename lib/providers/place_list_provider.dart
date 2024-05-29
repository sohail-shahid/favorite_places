import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as sys_path_provider;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:favorite_places/models/place_model.dart';

class PlaceListProviderNotifier extends StateNotifier<List<PlaceModel>> {
  PlaceListProviderNotifier() : super(const []);
  Future<Database> _openDatabase() async {
    final dbPath = await getDatabasesPath(); // from sqflit package

    final db = await openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) => {
        db.execute(
            'CREATE TABLE user_places (id TEXT PRIMARY KEY, title TEXT, imageName TEXT, lat REAL, lon REAL, address TEXT)')
      },
      version: 1,
    );
    return db;
  }

  Future<void> loadPlaces() async {
    final db = await _openDatabase();
    final data = await db.query('user_places');
    final appDir = await sys_path_provider.getApplicationDocumentsDirectory();

    final loadedPlaces = data.map((row) {
      final fileName = row['imageName'] as String;
      return PlaceModel(
        id: row['id'] as String,
        name: row['title'] as String,
        image: File('${appDir.path}/$fileName'),
        locationModel: PlaceLocationModel(
          name: row['address'] as String,
          lat: row['lat'] as double,
          long: row['lon'] as double,
        ),
      );
    }).toList();
    state = loadedPlaces;
    return;
  }

  void addPlace(PlaceModel model) async {
    final appDir = await sys_path_provider.getApplicationDocumentsDirectory();
    final fileName = path.basename(model.image.path);
    final imageOnNewLocation =
        await model.image.copy('${appDir.path}/$fileName');
    model.image = imageOnNewLocation;
    final db = await _openDatabase();
    db.insert('user_places', {
      'id': model.id,
      'title': model.name,
      'imageName': fileName,
      'lat': model.locationModel.lat,
      'lon': model.locationModel.long,
      'address': model.locationModel.name
    });
    state = [model, ...state];
  }
}

final placeListProvider =
    StateNotifierProvider<PlaceListProviderNotifier, List<PlaceModel>>(
  (ref) => PlaceListProviderNotifier(),
);
