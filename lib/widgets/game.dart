import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  Game({required this.game});
  int game;

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
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
