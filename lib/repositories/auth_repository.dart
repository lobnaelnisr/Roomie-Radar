import 'dart:io';

import '../models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> signUp(
      String email, String password, String name, File profilePic);
  Future<UserModel?> signIn(String email, String password);
  Future<UserModel?> getUserById(String id);
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Future<String> updateProfilePicture(String id, File profilePicture);
}
