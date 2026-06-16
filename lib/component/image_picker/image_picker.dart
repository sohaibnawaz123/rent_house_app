import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AppImagePicker {
  AppImagePicker._();

  static final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery
  static Future<File?> pickFromGallery({int imageQuality = 80}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: imageQuality,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Pick image from camera
  static Future<File?> pickFromCamera({int imageQuality = 80}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: imageQuality,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Common method
  static Future<File?> pickImage({
    required ImageSource source,
    int imageQuality = 80,
  }) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: imageQuality,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
