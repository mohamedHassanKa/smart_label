import 'package:flutter/material.dart';

String? validatePassword(String? pass1) {
  if (pass1 == null || pass1.isEmpty) return 'You need to add a password';
  // 1
  RegExp hasUpper = RegExp(r'[A-Z]');
  RegExp hasLower = RegExp(r'[a-z]');
  RegExp hasDigit = RegExp(r'\d');
  RegExp hasPunct = RegExp(r'[!@#\$&*~-]');
  // 2
  if (!RegExp(r'.{8,}').hasMatch(pass1)) return 'Passwords must have at least 8 characters';
  // 3
  if (!hasUpper.hasMatch(pass1)) return 'Passwords must have at least one uppercase character';
  // 4
  if (!hasLower.hasMatch(pass1)) return 'Passwords must have at least one lowercase character';
  // 5
  if (!hasDigit.hasMatch(pass1)) return 'Passwords must have at least one number';
  // 6
  if (!hasPunct.hasMatch(pass1)) return 'Passwords need at least one special character like !@#\$&*~-';
  // 7
  return null;
}

String? validateEmail(String? email) {
  // 1
  RegExp regex = RegExp(r'\w+@\w+\.\w+');
  // 2
  if (email == null || email.isEmpty)
    return 'We need an email address';
  else if (!regex.hasMatch(email))
    // 3
    return "That doesn't look like an email address";
  else
    // 4
    return null;
}

String? requiredValue(String? value) {
  if (value == null || value.isEmpty) return 'This field is required';

  return null;
}
