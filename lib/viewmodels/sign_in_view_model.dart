import 'package:flutter/material.dart';
import 'package:roomie_radar/models/user_model.dart';
import 'package:roomie_radar/repositories/auth_repository.dart';

class SignInViewModel {
  final AuthRepository repository;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  SignInViewModel({required this.repository});

  void _setLoading(bool value) {
    _isLoading = value;
  }

  Future<UserModel?> signIn() async {
    _setLoading(true);
    try {
      return await repository.signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    } catch (e) {
      throw Exception("An error occurred during sign-in.");
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
    } else if (value.length > 16) {
      return 'Password must be less than 16 characters';
    } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,16}$').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, and one number';
    }
    return null;
  }

  Future<void> resetPassword() async {
    if (formKey.currentState!.validate()) {
      try {
        await repository.resetPassword(emailController.text.trim());
      } catch (e) {
        throw Exception("An error occurred while resetting your password.");
      }
    }
  }
}
