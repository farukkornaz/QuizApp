import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/components/body.dart'; // custom body widget
import 'package:quiz_test_app/controllers/question_controller.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController()); // Access data from another screen (class) easily
    //_controller.onInit();

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        top: false,
        child:
         /* appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0, // shadow
            actions: [ // elements on app bar
              TextButton(onPressed: _controller.nextQuestion, child: Text('Atla')) // when press atla skip the question
            ],
          ), */
          Body(),

      ),
    );
  }
}
