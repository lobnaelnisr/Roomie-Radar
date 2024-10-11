import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:roomie_radar/models/user_model.dart';
import 'package:roomie_radar/repositories/auth_repository.dart';

class SignUpViewModel {
  final AuthRepository repository;
  bool isLoading = false;
  XFile? imageFile;

  SignUpViewModel({
    required this.repository,
  });

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    imageFile = await picker.pickImage(source: ImageSource.gallery);
  }

  Future<bool> signUp(String email, String password, String name) async {
    if (imageFile == null) {
      throw Exception("Profile picture is required.");
    }

    try {
      UserModel? user = await repository.signUp(
        email,
        password,
        name,
        File(imageFile!.path),
      );

      return user != null;
    } catch (e) {
      // Log error for debugging purposes
      print("Error during sign-up: $e");
      return false; // Return false if an error occurs
    }
  }

  void setLoading(bool value) {
    isLoading = value;
  }
}
