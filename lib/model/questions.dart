class Question {
  late String question;
  late int ind;
  late List<Map<String,dynamic>> answers;


  Question({required this.question,required this.ind,required this.answers});
}

List<Question> ques = [
  Question(
    question: 'You are at the Starting Island. Where do you wanna navigate to ?', 
    ind: 0, 
    answers: [
      {
        "text": 'To the Samurai Island? Your swordsman accompolishes his dream!',
        "points": 200,
        "next": 1,
      },
      {
        "text": 'To the Food Island? Your chef fulfills his dream!',
        "points": 200,
        "next": 2,
      },
      {
        "text": 'To the Fast Island? Quickly reach Raftel to claim max Treasure',
        "points": 50,
        "next": 3,
      }
  ],),
  Question(
    question: 'You arer Samurai Island. Where do you wanna navigate to ?', 
    ind: 1, 
    answers: [
      {
        "text": 'Take up a fast route to reach Raftel quickly?',
        "points": 50,
        "next": 4,
      },
      {
        "text": 'Move to the Food Island to let the Chef fulfill his dream!',
        "points": 200,
        "next": 2,
      }
  ],),
  Question(
    question: 'You are at the Food Island. Where do you wanna go next ?', 
    ind: 2, 
    answers: [
      {
        "text": 'Take up the Fast route to save some time.',
        "points": 50,
        "next": 4,
      },
      {
        "text": 'Move to the Risky Islands!',
        "points": 80,
        "next": 5,
      },
      {
        "text": 'Move to the Music Island to fulfill your Musician dream',
        "points": 200,
        "next": 6,
      }
  ],),
  Question(
    question: 'You are at the Fast Island. Where you wanna go next ?', 
    ind: 3, 
    answers: [
      {
        "text": 'To the Food Island to fulfill your Chef dream.',
        "points": 200,
        "next": 2,
      },
      {
        "text": 'Move to the Music Island',
        "points": 200,
        "next": 6,
      }
  ],),
  Question(
    question: 'Where do you wanna go next from the Fast Island?', 
    ind: 4, 
    answers: [
      {
        "text": 'To Raftel! finally the treasure',
        "points": 1000,
        "next": 7,
      }
  ],),
  Question(
    question: 'You are at the Risky island! Where you wanna gp next', 
    ind: 5, 
    answers: [
      {
        "text": 'To Raftel through the Risky road! Your Musician may learn his skill or You may reach your destination late! Its all about th risk!',
        "points": 1200,
        "next": 7,
      }
  ],),
  Question(
    question: 'You are at the Music Island, where you want to go ?', 
    ind: 6, 
    answers: [
      {
        "text": 'To Raftel! finally to the treasure.',
        "points": 1000,
        "next": 7,
      }
  ],),
];