import 'package:flutter/material.dart';
import 'package:roomie_radar/models/user_model.dart';
import 'package:roomie_radar/services/firebase/firebase_auth_service.dart';
import 'package:roomie_radar/utils/app_colors.dart';
import 'package:roomie_radar/views/authentication/components/custom_text_field.dart';
import 'package:roomie_radar/viewmodels/sign_in_view_model.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  // Create an instance of the ViewModel here
  late SignInViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SignInViewModel(repository: FirebaseAuthService());
    _viewModel.emailController = _emailController;
    _viewModel.passwordController = _passwordController;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        UserModel? user = await _viewModel.signIn();
        if (user != null) {
          // Navigate to home screen
        } else {
          _showErrorDialog("Invalid email or password");
        }
      } catch (e) {
        _showErrorDialog("An error occurred. Please try again later.");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorDialog(String message) {
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

  Future<void> _resetPassword() async {
    if (_emailController.text.isNotEmpty) {
      try {
        await _viewModel.resetPassword();
        _showSuccessDialog("Reset email sent.");
      } catch (e) {
        _showErrorDialog(e.toString());
      }
    } else {
      _showErrorDialog("Please enter your email to reset password.");
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
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
                  const _Header(),
                  const SizedBox(height: 60),
                  _EmailAndPasswordFields(
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  const SizedBox(height: 20),
                  _SignInButton(
                    isLoading: _isLoading,
                    onSignIn: _signIn,
                  ),
                  const SizedBox(height: 10),
                  _ForgotPasswordButton(
                    onResetPassword: _resetPassword,
                  ),
                  const SizedBox(height: 30),
                  const _SignUpButton(),
                ],
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
      'Welcome to Roomie Radar!',
      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}

class _EmailAndPasswordFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _EmailAndPasswordFields({
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            } else if (value.length < 8 || value.length > 16) {
              return 'Password must be 8-16 characters';
            } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,16}$')
                .hasMatch(value)) {
              return 'Password must contain uppercase, lowercase, and a number';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class _SignInButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onSignIn;

  const _SignInButton({
    required this.isLoading,
    required this.onSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ElevatedButton(
            onPressed: onSignIn,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text('Sign In', style: TextStyle(fontSize: 16)),
          );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  final VoidCallback onResetPassword;

  const _ForgotPasswordButton({
    required this.onResetPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onResetPassword,
        child: const Text(
          'Forgot Password?',
          style: TextStyle(fontSize: 14, color: appPrimaryColor),
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/signUp');
      },
      child: RichText(
        text: const TextSpan(
          text: "Don't have an account? ",
          style: TextStyle(color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: 'Sign Up',
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
