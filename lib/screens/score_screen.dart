import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/constants.dart';
//import 'package:quiz_test_app/controllers/auth_controller.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';


class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
    //TODO: kullancının bilgileri skor ekranında gozuksun
    //AuthController _aController = Get.find<AuthController>();
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.purple,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.all(kDefaultPadding * 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.purpleAccent,
                width: 3,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: Image.asset((() {
                    if (!_qnController.survivalActive && !_qnController.onlineActive) {
                      if (_qnController.correct * 3 <= _qnController.questionss!.length) {
                        return 'assets/images/madalyalar/bronze_medal.png';
                      } else if (_qnController.correct < _qnController.questionss!.length) {
                        return 'assets/images/madalyalar/silver_medal.png';
                      } else
                        return 'assets/images/madalyalar/gold_medal.png';
                    } else{
                      return 'assets/images/madalyalar/gold_medal.png';
                    }
                  })()),
                  //child: Image.asset(name),
                ),
                Expanded(
                  flex: 3,
                  child: getWidget(context),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.all(kDefaultPadding * 1.5),
                    child: InkWell(
                      // provides clickable and cool click animation
                      onTap: () {
                        _qnController.activeQuizId = "0";

                        _qnController.getQuizesScores();
                        _qnController.questReset();
                        _qnController.resetStatus();
                        Get.back();
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(kDefaultPadding / 2),
                        decoration: BoxDecoration(
                            gradient: kPrimaryGradient, borderRadius: BorderRadius.all(Radius.circular(12))),
                        child: AutoSizeText('Ana sayfa',
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white, fontSize: 17)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Toplam Skor', style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.purple)),
        const SizedBox(
          height: 10,
        ),
        Text(
            '${Get.find<QuestionController>().numOfCorrectAns * 10}${Get.find<QuestionController>().survivalActive ? " " : " / ${Get.find<QuestionController>().questionss!.length * 10}"}',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.purple)),
      ],
    );
  }
}

