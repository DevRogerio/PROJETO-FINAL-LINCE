import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// such as saving and loading files.
class LocalStorage {
  Future<File> _getLocalImage(String imageName) async {
    var dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$imageName');
  }

  /// Saves images into directory's path
  Future<File> saveImageLocal(File imageFile, String imageName) async {
    final file = await _getLocalImage(imageName);
    var result = await file.writeAsBytes(imageFile.readAsBytesSync());
    return result;
  }

  /// Loads any file within the app's directory
  Future<File> loadImageLocal(String imageName) async {
    final file = await _getLocalImage(imageName);
    if (!file.existsSync()) {
      throw const FormatException('Could not locate file');
    }
    return file;
  }
}
