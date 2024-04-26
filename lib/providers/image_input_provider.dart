import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageInputProviderNotifier extends StateNotifier<File?> {
  ImageInputProviderNotifier(super.file);

  void setImage(File imageFile) {
    state = imageFile;
  }

  void deleteImage() {
    state = null;
  }
}

final imageInputProvider =
    StateNotifierProvider<ImageInputProviderNotifier, File?>(
  (ref) {
    return ImageInputProviderNotifier(null);
  },
);
