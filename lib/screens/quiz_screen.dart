import 'package:flutter/material.dart';
import 'package:quiz_test_app/components/body.dart'; // custom body widget

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        top: false,
        child: Body(),
      ),
    );
  }
}
