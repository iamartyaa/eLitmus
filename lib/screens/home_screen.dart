import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pirate_hunt/model/user_model.dart';
import 'package:pirate_hunt/screens/login_screen.dart';
import 'package:pirate_hunt/widgets/game.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  int gameState = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pirate Hunt'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.amber,
              ),
            ),
            ListTile(
              title: Text(
                "Username : ${loggedInUser.userName}",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Highest score: ${loggedInUser.score ?? 0}'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ActionChip(
              backgroundColor: Colors.redAccent,
              label: const Text(
                "LogOut",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
      body: gameState < 0
          ? Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Welcome ${loggedInUser.userName} !',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          gameState=0;
                        });
                      },
                      child: Text('Start Puzzle'),
                    ),
                  ],
                ),
              ),
            )
          : Game(game: gameState, name: loggedInUser.userName, email: loggedInUser.email, score: loggedInUser.score),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const LoginScreen(),
      ),
    );
  }
}
