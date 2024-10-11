import 'package:flutter/material.dart';
import 'package:roomie_radar/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final IconButton? suffixIcon;
  final TextInputType keyboardType; // Make keyboardType a member variable
  final int maxLines; // Make maxLines a member variable

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.keyboardType = TextInputType.text, // Provide a default value
    this.maxLines = 1, // Provide a default value
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType, // Use keyboardType here
      maxLines: maxLines, // Use maxLines here
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        prefixIcon: Icon(icon, color: appPrimaryColor),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
