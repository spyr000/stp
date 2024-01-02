import 'package:flutter/material.dart';

import 'auth/auth_service.dart';
import 'home_screen.dart';
import 'auth/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Authentication Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AuthService.isLoggedIn ? '/home' : '/login',
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}