import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pirate_hunt/model/questions.dart';
import 'package:pirate_hunt/model/user_model.dart';
import 'package:pirate_hunt/screens/home_screen.dart';

class Game extends StatefulWidget {
  Game(
      {required this.game,
      required this.name,
      required this.email,
      required this.score});
  int game;
  int? score;
  String? email;
  String? name;

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  var score = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            "assets/onepiecemap.png",
          ),
        ),
        if (widget.game >= 7)
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const Text(
                    'Yahoo! You reached Raftel. You are a Pirate King now :)'),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                    'Thank you for attending the Puzzle. I hope you liked it.'),
                const SizedBox(
                  height: 20,
                ),
                Text('Current Score : ${score}'),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () {
                    postDetailsToFirestore();
                  },
                  child: const Text('Home'),
                ),
              ],
            ),
          ),
        if (widget.game >= 1 && widget.game < 7)
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(ques[widget.game - 1].question),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 300,
                  child: ListView.builder(
                    itemBuilder: (ctx, i) {
                      return ElevatedButton(
                        onPressed: () {
                          print(widget.game);

                          setState(() {
                            score += ques[widget.game - 1].answers[i]["points"]
                                as int;
                            widget.game =
                                ques[widget.game - 1].answers[i]["next"] + 1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            ques[widget.game - 1].answers[i]["text"],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                    itemCount: ques[widget.game - 1].answers.length,
                  ),
                )
              ],
            ),
          ),
        if (widget.game == 0) const Instructions(),
        if (widget.game == 0)
          Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.game += 1;
                });
              },
              child: const Text('Start'),
            ),
          ),
      ],
    );
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    final _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = widget.email;
    userModel.uid = user!.uid;
    userModel.userName = widget.name;
    userModel.score = score;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Puzzle completed!");
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx) => const HomeScreen()),
        (route) => false);
  }
}

class Instructions extends StatelessWidget {
  const Instructions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
              'You are a Pirate who dreams to be a Pirate King by claming the tresure of the Raftel Island. In your crew, there is a Swordsman, a Chef and a Musician, each of them separately dreams to be the master of their trade.'),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Text(
              'Your task is to reach Raftel within 3 days to claim the tresure alongwith fulfilling other duties on the route. The catch is, The value of tresure declines each day by 100 coins after the 2nd day. Try to maximize the score by making optimal choices!'),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 10),
          child: Text(
              'You can refer the RuleBook & the Points system on the left drawer to Score maximum.'),
        ),
      ],
    );
  }
}
