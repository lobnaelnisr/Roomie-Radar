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

  // Declare an abstract method for updating user profiles
  Future<void> updateUser(UserModel user);
}

/*@override
Future<void> updateUser(UserModel user) async {
  try {
    await _firestore.collection('users').doc(user.id).update(user.toMap());
  } catch (e) {
    throw Exception("Error updating user profile: $e");
  }
}*/
