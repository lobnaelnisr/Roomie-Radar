import 'package:roomie_radar/models/user_model.dart';
import 'package:roomie_radar/repositories/auth_repository.dart';

class SignInViewModel {
  final AuthRepository repository;

  SignInViewModel({required this.repository});

  Future signIn(String email, String password) async {
    UserModel? user = await repository.signIn(email, password);
    if (user != null) {
      // Navigate to home screen
    } else {
      throw Exception("Invalid email or password");
    }
  }

  Future resetPassword(String email) async {
    await repository.resetPassword(email);
  }
}
