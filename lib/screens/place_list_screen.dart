import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/providers/place_list_provider.dart';
import 'package:favorite_places/screens/add_new_place_screen.dart';
import 'package:favorite_places/widgets/place_list_view.dart';

class PlaceListScreen extends ConsumerStatefulWidget {
  const PlaceListScreen({super.key});
  @override
  ConsumerState<PlaceListScreen> createState() {
    return _PlaceListScreenState();
  }
}

class _PlaceListScreenState extends ConsumerState<PlaceListScreen> {
  late Future<void> _loadPlacesFuture;
  void _onAddNewPlaceButtonPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddNewPlaceScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadPlacesFuture = ref.read(placeListProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
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
        child: FutureBuilder(
          future: _loadPlacesFuture,
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : PlaceListView(
                    placeList: placeList,
                  );
          },
        ),
      ),
    );
  }
}
