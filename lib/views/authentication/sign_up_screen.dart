import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roomie_radar/services/firebase/firebase_auth_service.dart';
import 'package:roomie_radar/utils/app_colors.dart';
import 'package:roomie_radar/views/authentication/components/custom_text_field.dart';
import 'package:roomie_radar/viewmodels/sign_up_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final SignUpViewModel viewModel =
      SignUpViewModel(repository: FirebaseAuthService());

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    await viewModel.pickImage();
    setState(() {}); // Refresh UI after image selection
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        viewModel.setLoading(true);
      });

      try {
        bool success = await viewModel.signUp(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _nameController.text.trim(),
        );

        if (success) {
          Navigator.pushReplacementNamed(context, '/signIn');
        } else {
          _showDialog("Sign Up failed! Please try again.", isError: true);
        }
      } catch (e) {
        _showDialog("Error occurred during sign-up: ${e.toString()}",
            isError: true);
      } finally {
        // Ensure loading stops regardless of success or failure
        setState(() {
          viewModel.setLoading(false);
        });
      }
    }
  }

  void _showDialog(String message, {required bool isError}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isError ? "Error" : "Success"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _SignUpHeader(),
                  const SizedBox(height: 40),
                  _ProfileImagePicker(
                    imageFile: viewModel.imageFile,
                    onPickImage: _pickImage,
                  ),
                  const SizedBox(height: 40),
                  _SignUpFields(
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  const SizedBox(height: 20),
                  _SignUpButton(
                    isLoading: viewModel.isLoading,
                    onSignUp: _signUp,
                  ),
                  const SizedBox(height: 20),
                  const _SignInLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignUpHeader extends StatelessWidget {
  const _SignUpHeader();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Create an Account',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: appPrimaryColor,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _ProfileImagePicker extends StatelessWidget {
  final XFile? imageFile;
  final VoidCallback onPickImage;

  const _ProfileImagePicker({
    required this.imageFile,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPickImage,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey[300],
        backgroundImage:
            imageFile != null ? FileImage(File(imageFile!.path)) : null,
        child: imageFile == null
            ? const Icon(Icons.camera_alt, size: 40, color: Colors.white)
            : null,
      ),
    );
  }
}

class _SignUpFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _SignUpFields({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: nameController,
          labelText: 'Name',
          icon: Icons.person,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: emailController,
          labelText: 'Email',
          icon: Icons.email,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                .hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: passwordController,
          labelText: 'Password',
          icon: Icons.lock,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            } else if (value.length < 8) {
              return 'Password must be at least 8 characters';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class _SignUpButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onSignUp;

  const _SignUpButton({
    required this.isLoading,
    required this.onSignUp,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ElevatedButton(
            onPressed: onSignUp,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor: appPrimaryColor,
            ),
            child: const Text('Sign Up', style: TextStyle(fontSize: 16)),
          );
  }
}

class _SignInLink extends StatelessWidget {
  const _SignInLink();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/signIn');
      },
      child: RichText(
        text: const TextSpan(
          text: 'Already have an account? ',
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: appPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
