import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/models/place_model.dart';

class PlaceListProviderNotifier extends StateNotifier<List<PlaceModel>> {
  PlaceListProviderNotifier() : super(const []);

  void addPlace(PlaceModel model) {
    state = [model, ...state];
  }
}

final placeListProvider =
    StateNotifierProvider<PlaceListProviderNotifier, List<PlaceModel>>(
  (ref) => PlaceListProviderNotifier(),
);
