import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/providers/place_list_provider.dart';
import 'package:favorite_places/screens/add_new_place_screen.dart';
import 'package:favorite_places/widgets/place_list_view.dart';

class PlaceListScreen extends ConsumerWidget {
  const PlaceListScreen({super.key});

  void _onAddNewPlaceButtonPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddNewPlaceScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var placeList = ref.watch(placeListProvider);
    print(
      placeList.toString(),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Places'),
        actions: [
          IconButton(
            onPressed: () {
              _onAddNewPlaceButtonPressed(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlaceListView(
          placeList: placeList,
        ),
      ),
    );
  }
}
