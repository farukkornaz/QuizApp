import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/constants.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';
import 'package:quiz_test_app/models/quizes.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({super.key, required this.quizes});

  final Quizes quizes;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Stack(
        children: [
          Container(
            width: 130,
            height: 120,
            decoration: BoxDecoration(
              color: quizes.category == 1
                  ? nkColor
                  : quizes.category == 2
                      ? iaColor
                      : hloiColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      quizes.quizName!,
                      style: TextStyle(fontSize: 20, fontFamily: 'Swissblack'),
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
          SizedBox(height: 5),
          Positioned(
            bottom: -5,
            left: 0,
            right: 0,
            child: Container(
              height: 25,
              margin: EdgeInsets.only(bottom: 5),
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    _controller.getTheRightQuestions(quizes.questionsId ?? '');
                    _controller.activeQuiz = quizes.id! - 1;
                    _controller.getQuizScreen();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30), backgroundColor: Colors.purple.withOpacity(0.5),
                    side: BorderSide(width: 1, style: BorderStyle.solid, color: Colors.white),

                    /*Color primary, // set the background color
                      TextStyle textStyle,
                      Size minimumSize,
                      BorderSide side,
                      OutlinedBorder shape,*/
                  ),
                  child: Text(
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
