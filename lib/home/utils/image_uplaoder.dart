import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:images_to_pdf/utils/permission_handler.dart';

class ImageUploader {
  static Future<File?> pickImage() async {
    File? imageTemp;
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      imageTemp = File(image.path);

      return imageTemp;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    return null;
  }

  static Future<File?> captureImage() async {
    File? imageTemp;
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return null;
      imageTemp = File(image.path);
      return imageTemp;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    return null;
  }
}
