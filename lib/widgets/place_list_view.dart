import 'package:favorite_places/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:favorite_places/models/place_model.dart';

class PlaceListView extends StatelessWidget {
  const PlaceListView({
    super.key,
    required this.placeList,
  });
  final List<PlaceModel> placeList;
  @override
  Widget build(BuildContext context) {
    if (placeList.isEmpty) {
      return const Center(
        child: Text(
          'No places added yet',
        ),
      );
    }
    return ListView.builder(
      itemCount: placeList.length,
      itemBuilder: (context, index) {
        return ListTile(
            leading: CircleAvatar(
              radius: 26,
              backgroundImage: FileImage(placeList[index].image),
            ),
            title: Text(
              placeList[index].name,
            ),
            subtitle: Text(placeList[index].locationModel.name),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      PlaceDetailScreen(placeModel: placeList[index]),
                ),
              );
            });
      },
    );
  }
}
