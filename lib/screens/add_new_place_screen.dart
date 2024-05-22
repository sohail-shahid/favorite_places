import 'package:favorite_places/providers/image_input_provider.dart';
import 'package:favorite_places/widgets/image_input_view.dart';
import 'package:favorite_places/widgets/location_input_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/models/place_model.dart';
import 'package:favorite_places/providers/place_list_provider.dart';

class AddNewPlaceScreen extends ConsumerStatefulWidget {
  const AddNewPlaceScreen({super.key});

  @override
  ConsumerState<AddNewPlaceScreen> createState() {
    return _AddNewPlaceScreenState();
  }
}

class _AddNewPlaceScreenState extends ConsumerState<AddNewPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  PlaceLocationModel? locationModel;
  void _onLocationSelected(PlaceLocationModel model) {
    locationModel = model;
  }

  void _onSaveButtonPressed() {
    final isValidated = _formKey.currentState?.validate() ?? false;
    final selectedImage = ref.read(imageInputProvider);

    if (isValidated && selectedImage != null && locationModel != null) {
      _formKey.currentState?.save();
      PlaceModel model = PlaceModel(
          name: _name!, image: selectedImage, locationModel: locationModel!);
      ref.read(placeListProvider.notifier).addPlace(model);
      ref.read(imageInputProvider.notifier).deleteImage();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('name'),
                  ),
                  validator: (value) {
                    String? errorMessage;
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length >= 50) {
                      errorMessage = 'Value must be between 0 and 5 chracters';
                    }
                    return errorMessage;
                  },
                  onSaved: (value) {
                    print(value);
                    _name = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const ImageInputView(),
                const SizedBox(
                  height: 20,
                ),
                LocationInputView(
                  onLocationSelected: _onLocationSelected,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _onSaveButtonPressed,
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
