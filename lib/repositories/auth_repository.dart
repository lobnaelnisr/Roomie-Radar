import '../models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> signUp(String email, String password, String name);
  Future<UserModel?> signIn(String email, String password);
  Future<UserModel?> getUserById(String id);
  Future<void> signOut();
  Future<void> resetPassword(String email);
}
