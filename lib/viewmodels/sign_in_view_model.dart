import 'package:roomie_radar/models/user_model.dart';
import 'package:roomie_radar/repositories/auth_repository.dart';

class SignInViewModel {
  final AuthRepository repository;

  SignInViewModel({required this.repository});

  // Handles sign-in with email and password.
  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserModel? user = await repository.signIn(email, password);
      if (user != null) {
        // User successfully signed in
        return user;
      } else {
        throw Exception("Invalid email or password");
      }
    } catch (e) {
      // Propagate error for handling in the UI layer
      throw Exception("Sign-in failed: ${e.toString()}");
    }
  }

  // Sends a password reset email.
  Future<void> resetPassword(String email) async {
    try {
      await repository.resetPassword(email);
    } catch (e) {
      throw Exception("Error resetting password: ${e.toString()}");
    }
  }
}
