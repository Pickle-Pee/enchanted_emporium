import 'package:flutter/material.dart';
import 'package:enchanted_emporium/screens/forgot_password_screen.dart';
import 'package:enchanted_emporium/screens/profile_screen.dart';
import 'package:enchanted_emporium/screens/home_screen.dart';
import 'package:enchanted_emporium/screens/signup_screen.dart';
import 'package:enchanted_emporium/screens/login_screen.dart';
import 'package:enchanted_emporium/screens/splash_screen.dart';
import 'package:enchanted_emporium/screens/cart_screen.dart';

void main() {
  runApp(EnchantedEmporium());
}

class EnchantedEmporium extends StatelessWidget {
  final List<Map<String, dynamic>> _cart = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enchanted Emporium',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(cart: _cart),
        '/signup': (context) => SignUpScreen(),
        '/login': (context) => LoginScreen(),
        '/forgot_password': (context) => ForgotPasswordScreen(),
        '/profile': (context) => ProfileScreen(cart: _cart),
        '/cart': (context) => CartScreen(cart: _cart),
      },
    );
  }
}
