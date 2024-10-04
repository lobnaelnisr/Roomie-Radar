import 'package:flutter/material.dart';
import 'package:roomie_radar/models/user_model.dart';
import 'package:roomie_radar/repositories/auth_repository.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthRepository repository;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  SignUpViewModel({required this.repository});

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<UserModel?> signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      throw Exception("Passwords do not match");
    }

    _setLoading(true);
    try {
      UserModel? user = await repository.signUp(
        emailController.text.trim(),
        passwordController.text.trim(),
        nameController.text.trim(),
      );
      return user;
    } catch (e) {
      throw Exception("An error occurred during sign-up.");
    } finally {
      _setLoading(false);
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
