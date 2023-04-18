import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pirate_hunt/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pirate_hunt/screens/signup_screen.dart';

import 'screens/drop_screen.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bazaar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ), 
      
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const DropScreen();
          }

          if (userSnapshot.hasData) {
            return const HomeScreen();
          }
          else {
            return const LoginScreen();
          }
        },
      ),
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName:(context) => const SignUpScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        DropScreen.routeName: (context) => const DropScreen(),
      },
    );
  }
}
