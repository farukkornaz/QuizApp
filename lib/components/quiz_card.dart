import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/constants.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';

import '../models/Quiz.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({super.key, required this.quizes});

  final Quiz quizes;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Stack(
        children: [
          Container(
            width: 130,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      quizes.name!,
                      style: const TextStyle(fontSize: 20, fontFamily: 'Swissblack'),
                    ),
                  ),
                ]),
          ),
          /*ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Image.asset(quizes.imageUrl,fit: BoxFit.cover, width: 170 , height: 120,)
          ),*/
          /*Positioned(
            top: 0,
            left: 5,
            right: 0,
            bottom: 0,
            child: Text(quizes.quizName,style: TextStyle(color: Colors.black87),),
          ),*/
          const SizedBox(height: 5),
          Positioned(
            bottom: -5,
            left: 0,
            right: 0,
            child: Container(
              height: 25,
              margin: const EdgeInsets.only(bottom: 5),
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    _controller.getTheRightQuestions("dsf");
                    _controller.activeQuizId = quizes.id;
                    _controller.getQuizScreen();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30), backgroundColor: Colors.purple.withOpacity(0.5),
                    side: const BorderSide(width: 1, style: BorderStyle.solid, color: Colors.white),

                    /*Color primary, // set the background color
                      TextStyle textStyle,
                      Size minimumSize,
                      BorderSide side,
                      OutlinedBorder shape,*/
                  ),
                  child: const Text(
                    'Çöz !',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
