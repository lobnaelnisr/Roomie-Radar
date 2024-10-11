import 'package:flutter/material.dart';
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
        final user = await viewModel.signIn(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        if (user != null) {
          // Navigate to home screen or other
          Navigator.pushReplacementNamed(context, '/roomListing');
        }
      } catch (e) {
        _showDialog(e.toString(), isError: true);
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
                  const _Logo(),
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
    return Text(
      "Sign In",
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: appPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo.png',
      width: 150,
      height: 150,
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
          labelText: "Email",
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your email";
            }
            return null;
          },
          icon: Icons.email,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: passwordController,
          labelText: "Password",
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your password";
            }
            return null;
          },
          icon: Icons.lock,
          keyboardType: TextInputType.visiblePassword,
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
    return ElevatedButton(
      onPressed: isLoading ? null : onSignIn,
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : const Text("Sign In"),
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
    return TextButton(
      onPressed: onResetPassword,
      child: const Text("Forgot Password?"),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/signUp');
      },
      child: const Text("Don't have an account? Sign Up"),
    );
  }
}
