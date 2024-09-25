import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final fileControllerProvider = Provider((ref) => FileController());

class FileController {
  Future<File?> selectFile() async {
    try{
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source:ImageSource.gallery);
      File imageFile = File(image!.path);
      return imageFile;
    } catch(e){
      print("Fialed to pick image");
      return null;
    }
  }
}