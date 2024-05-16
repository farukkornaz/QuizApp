import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_test_app/models/Quiz.dart';
import 'package:quiz_test_app/screens/welcome_screen.dart';

import '../constants.dart';
import '../models/Question.dart';

class QuizzesScreen extends StatefulWidget {

  List<Quiz> quizzes;
  QuizzesScreen(this.quizzes, {super.key});

  @override
  State<QuizzesScreen> createState() => _QuizzesScreenState();
}

class _QuizzesScreenState extends State<QuizzesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: widget.quizzes.length,

        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                CategorySample(quiz: widget.quizzes[index]),
              ],
            ),
          );
        },
      ),
    );
  }
}
