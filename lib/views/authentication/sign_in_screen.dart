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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  final SignInViewModel viewModel =
      SignInViewModel(repository: FirebaseAuthService());

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      _setLoading(true);
      try {
        await viewModel.signIn(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        // Navigate to home screen or other
      } catch (e) {
        _showDialog("An error occurred. Please try again later.",
            isError: true);
      } finally {
        _setLoading(false);
      }
    }
  }

  Future<void> _resetPassword() async {
    if (_emailController.text.isNotEmpty) {
      try {
        await viewModel.resetPassword(
          _emailController.text.trim(),
        );
        _showDialog("Password reset link sent to your email.", isError: false);
      } catch (e) {
        _showDialog(e.toString(), isError: true);
      }
    } else {
      _showDialog("Please enter your email to reset password.", isError: true);
    }
  }

  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  void _showDialog(String message, {required bool isError}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                  const _Header(),
                  const SizedBox(height: 40),
                  const _Logo(), // Optional logo widget
                  const SizedBox(height: 40),
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
      'Welcome Back!',
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

class _EmailAndPasswordFields extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _EmailAndPasswordFields({
    required this.emailController,
    required this.passwordController,
  });

  @override
  _EmailAndPasswordFieldsState createState() => _EmailAndPasswordFieldsState();
}

class _EmailAndPasswordFieldsState extends State<_EmailAndPasswordFields> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: widget.emailController,
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
          controller: widget.passwordController,
          labelText: 'Password',
          icon: Icons.lock,
          obscureText: !_isPasswordVisible,
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
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
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
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor:
                  appPrimaryColor, // Use primary color for the button
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
