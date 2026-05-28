import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFE67E22), Color(0xFFD35400)])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_checkout, size: 100, color: Colors.white),
            SizedBox(height: 50),
            _actionButton("Login / Register", Colors.white, Color(0xFFD35400), () {}),
            SizedBox(height: 20),
            _actionButton("Browse as Guest", Colors.transparent, Colors.white, () {}),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(String label, Color bg, Color text, VoidCallback tap) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: bg,
        side: BorderSide(color: Colors.white),
        minimumSize: Size(250, 50),
      ),
      onPressed: tap,
      child: Text(label, style: TextStyle(color: text, fontWeight: FontWeight.bold)),
    );
  }
}