import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/components/info_card.dart';
import 'package:quiz_test_app/controllers/auth_controller.dart';
import 'package:quiz_test_app/controllers/quiz_controller.dart';

class InfoScreen extends GetWidget<AuthController> {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX<QuizController>(
        //init: Get.find<QuizController>(),
        init: Get.put<QuizController>(QuizController()),
        builder: (QuizController quizController) {
          if (quizController != null && quizController.quizinfo != null) {
            //Text(quizController.quizinfo[0].score);
            return Expanded(
              child: ListView.builder(
                itemCount: quizController.quizinfo.length,
                itemBuilder: (_, index) {
                  return InfoCard(uid: controller.user?.uid ?? '', qm: quizController.quizinfo[index]);
                },
              ),
            );
          } else {
            return Text("loading...");
          }
        },
      ),
    );
  }
}
