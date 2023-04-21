import 'package:flutter/material.dart';

class DropScreen extends StatelessWidget {
  static const routeName = '/drop-screen';
  const DropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Image.asset('assets/logo.png'),
        const Text('Welcome to Pirate Hunt'),
      ],),
    );
  }
}