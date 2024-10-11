import 'dart:io';

import 'package:roomie_radar/models/user_model.dart';
import 'package:roomie_radar/repositories/auth_repository.dart';

class SignUpViewModel {
  final AuthRepository repository;
  SignUpViewModel({
    required this.repository,
  });

  Future<bool> signUp(
      String email, String password, String name, File profilePic) async {
    UserModel? user =
        await repository.signUp(email, password, name, profilePic);

    try {
      if (user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Error signing up: $e");
    }
  }
}
