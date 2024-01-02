import 'package:flutter/material.dart';

class AuthService {
  static bool isLoggedIn = false;

  static Future<bool> login(String username, String password) async {
    var isAuthenticated = (username == 'user' && password == 'password');

    if (isAuthenticated) {
      isLoggedIn = true;
    }

    return isAuthenticated;
  }

  static void logout(BuildContext context) {
    isLoggedIn = false;
    Navigator.pushReplacementNamed(context, '/login');
  }
}