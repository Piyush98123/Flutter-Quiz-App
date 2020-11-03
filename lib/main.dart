import 'package:flutter/material.dart';
import 'quizbank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBank quizBank = QuizBank();
void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Quiz(),
      ),
    ),
  );
}

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<Icon> score = [];
  void answers(bool userpicked) {
    setState(() {
      bool ans = quizBank.getAnswer();
      if (quizBank.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();
        quizBank.reset();
        score = [];
      } else {
        if (userpicked == ans) {
          score.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          score.add(
            Icon(Icons.close, color: Colors.red),
          );
        }
        quizBank.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Text(quizBank.getQuestion(),
                style: TextStyle(color: Colors.white, fontSize: 25.0),
                textAlign: TextAlign.center),
          ),
        ),
        Expanded(
          child: FlatButton(
            child: Text(
              'True',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            color: Colors.greenAccent,
            onPressed: () {
              answers(true);
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: FlatButton(
            child: Text(
              'False',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            color: Colors.redAccent,
            onPressed: () {
              answers(false);
            },
          ),
        ),
        Row(
          children: score,
        ),
      ],
    );
  }
}
