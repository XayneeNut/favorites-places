import 'dart:io';

import 'package:favorite_places/generator/random_int_id.dart';
import 'package:favorite_places/models/favorite_place_model.dart';
import 'package:favorite_places/models/location_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE user_places(id INTEGER PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
  }, version: 1);

  return db;
}

class UserPlaceNotifier extends StateNotifier<List<FavoritePlaceModel>> {
  UserPlaceNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data
        .map(
          (row) => FavoritePlaceModel(
            name: row['title'] as String,
            id: row['id'] as int,
            image: File(row['image'] as String),
            location: LocationModel(
                latitude: row['lat'] as double,
                longitude: row['lng'] as double,
                formatedAddress: row['address'] as String),
          ),
        )
        .toList();

    state = places;
  }

  void addPlace(String title, File image, LocationModel locationModel) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace = FavoritePlaceModel(
        name: title,
        image: copiedImage,
        id: RandomIntId().gusantaIdGen(),
        location: locationModel);
    state = [newPlace, ...state];

    final db = await _getDatabase();

    db.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.name,
        'image': newPlace.image.path,
        'lat': newPlace.location.latitude,
        'lng': newPlace.location.longitude,
        'address': newPlace.location.formatedAddress
      },
    );
  }
}

final userPlaceProvider =
    StateNotifierProvider<UserPlaceNotifier, List<FavoritePlaceModel>>(
  (ref) => UserPlaceNotifier(),
);
