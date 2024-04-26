import 'dart:io';

import 'package:favorite_places/providers/image_input_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImageInputView extends ConsumerStatefulWidget {
  const ImageInputView({super.key});
  @override
  ConsumerState<ImageInputView> createState() {
    return _ImageInputViewState();
  }
}

class _ImageInputViewState extends ConsumerState<ImageInputView> {
  void _onTakeImage() async {
    final imagePicker = ImagePicker();
    ImageSource source = Theme.of(context).platform == TargetPlatform.iOS
        ? ImageSource.gallery
        : ImageSource.camera;
    final selectedImageFile = await imagePicker.pickImage(
      source: source,
      maxWidth: 600,
    );
    if (selectedImageFile == null) {
      return;
    }
    final imageImage = File(selectedImageFile.path);
    ref.read(imageInputProvider.notifier).setImage(imageImage);
  }

  @override
  Widget build(BuildContext context) {
    final selectedImage = ref.watch(imageInputProvider);
    Widget child = TextButton.icon(
      onPressed: _onTakeImage,
      icon: const Icon(Icons.camera),
      label: const Text('Take Picture'),
    );
    if (selectedImage != null) {
      child = GestureDetector(
        onTap: _onTakeImage,
        child: Image.file(
          selectedImage,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
      );
    }
    return Container(
        height: 250,
        width: double.infinity,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1, color: Theme.of(context).colorScheme.onBackground),
        ),
        child: child);
  }
}
