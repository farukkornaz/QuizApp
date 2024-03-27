import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/cooldown_controller.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';
import 'package:quiz_test_app/screens/score_screen.dart';

class CircularCooldown extends StatelessWidget {
  const CircularCooldown({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    CooldownControl _ccontroller = Get.put(CooldownControl());

    return GetBuilder<CooldownControl>(
        // TODO İmplement it to quiz screen
        init: CooldownControl(),
        builder: (controller) {
          return Center(
            child: Row(
              children: [
                CircularCountDownTimer(
                    isReverse: true,
                    width: 50,
                    height: 50,
                    textFormat: CountdownTextFormat.S,
                    duration: 30,
                    fillColor: Colors.purple.shade100,
                    ringColor: Colors.purple,
                    controller: controller.ccontroller,
                    autoStart: true,
                    onComplete: () {
                      if (_controller.wrong.value == 2) {
                        Get.off(ScoreScreen());
                      } else {
                        _controller.wrong.value++;
                        _controller.survivalNextQuestion();
                        _controller.alreadyAnswered = false;
                        _ccontroller.restart();
                      }
                      _controller.alreadyAnswered = false;
                    } //SURVİVAL GG
                    ),
              ],
            ),
          );
        });
  }
}
