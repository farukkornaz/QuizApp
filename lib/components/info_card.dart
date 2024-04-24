import 'package:flutter/material.dart';
import 'package:quiz_test_app/models/quiz_DB.dart';

class InfoCard extends StatelessWidget {
  final String? uid;
  final QuizModel? qm;

  const InfoCard({super.key, this.uid, this.qm});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          Expanded(
              child: Text(
            qm?.score ?? '',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          )),
          Checkbox(
              value: qm?.done,
              onChanged: (newValue) {
                //Database().updateQuiz(newValue,uid,qm.quizId);
              }),
        ],
      ),
    );
  }
}
