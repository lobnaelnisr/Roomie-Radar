import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomie_radar/models/user_model.dart';
import 'package:roomie_radar/services/firebase/firebase_auth_service.dart';
import 'package:roomie_radar/utils/app_colors.dart';
import 'package:roomie_radar/viewmodels/sign_up_view_model.dart';
import 'package:roomie_radar/views/authentication/components/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SignUpViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SignUpViewModel(repository: FirebaseAuthService());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpViewModel>(
      create: (_) => _viewModel,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _viewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    _Header(),
                    SizedBox(height: 40),
                    _Logo(), // Optional logo widget
                    SizedBox(height: 40),
                    _EmailAndPasswordFields(),
                    SizedBox(height: 20),
                    _SignUpButton(),
                    SizedBox(height: 30),
                    _SignInButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

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

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo.png', // Adjust the path to your logo
      height: 120,
    );
  }
}

class _EmailAndPasswordFields extends StatelessWidget {
  const _EmailAndPasswordFields();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignUpViewModel>(context);
    return Column(
      children: [
        CustomTextField(
          controller: viewModel.emailController,
          labelText: 'Email',
          icon: Icons.email,
          validator: viewModel.validateEmail,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: viewModel.passwordController,
          labelText: 'Password',
          icon: Icons.lock,
          obscureText: true,
          validator: viewModel.validatePassword,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: viewModel.confirmPasswordController,
          labelText: 'Confirm Password',
          icon: Icons.lock,
          obscureText: true,
          validator: viewModel.validateConfirmPassword,
        ),
      ],
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpViewModel>(
      builder: (context, viewModel, child) {
        return viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                onPressed: () async {
                  if (viewModel.formKey.currentState!.validate()) {
                    try {
                      UserModel? user = await viewModel.signUp();
                      if (user != null) {
                        // Navigate to home screen
                      } else {
                        _showErrorDialog(context, "Sign-up failed");
                      }
                    } catch (e) {
                      _showErrorDialog(
                          context, "An error occurred. Please try again.");
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Rounded corners
                  ),
                  backgroundColor:
                      appPrimaryColor, // Primary color for the button
                ),
                child: const Text('Sign Up', style: TextStyle(fontSize: 16)),
              );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
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
}

class _SignInButton extends StatelessWidget {
  const _SignInButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/signIn');
      },
      child: RichText(
        text: const TextSpan(
          text: "Already have an account? ",
          style: TextStyle(color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: appPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
