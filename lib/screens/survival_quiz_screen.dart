import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/components/circular_cooldown.dart';
import 'package:quiz_test_app/components/question_card.dart';
import 'package:quiz_test_app/controllers/cooldown_controller.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';

import '../constants.dart'; // question controller class

class SurvivalQuizScreen extends StatelessWidget {
  const SurvivalQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController questionController = Get.find<QuestionController>();
    //QuestionController _controller = Get.put(QuestionController());
    CooldownControl cooldownController = Get.put(CooldownControl());
    //_controller.onInit();

    return PopScope(
      canPop: false,
      child: SafeArea(
        top: false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.purple,
          body: SafeArea(
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Container(
                      height: 185,
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                        //color: Colors.white.withOpacity(0.3),
                        //borderRadius: BorderRadius.all(Radius.circular(10)),),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(kDefaultPadding, 0, 0, 0),
                                child: Obx(() => questionController.survHigh.value <
                                        questionController.survivalScores[
                                            (int.tryParse((questionController.activeSurvivalQuiz?.substring(5, 6)) ?? '') ??
                                                    0) -
                                                1]
                                    ? Text(
                                        "En Yüksek Skor : ${questionController.survivalScores[(int.tryParse(questionController.activeSurvivalQuiz?.substring(5, 6) ?? '') ?? 0) - 1]}",
                                        style: const TextStyle(color: Colors.white),
                                      )
                                    : Text(
                                        "En Yüksek Skor : ${questionController.survHigh.value}",
                                        style: const TextStyle(color: Colors.white),
                                      )),
                              ),
                              InkWell(
                                // provides clickable and cool click animation
                                onTap: () {
                                  Get.back();
                                  questionController.questReset();
                                  questionController.resetStatus();
                                  questionController.survivalActive = false;
                                  questionController.alreadyAnswered = false;
                                },
                                child: Container(
                                  width: 26,
                                  height: 26,
                                  margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  alignment: Alignment.center,
                                  //padding: EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                      color: Colors.redAccent, borderRadius: BorderRadius.all(Radius.circular(25))),
                                  child: const Icon(
                                    Icons.close_rounded,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(kDefaultPadding, 5, kDefaultPadding, 0),
                            padding: const EdgeInsets.fromLTRB(kDefaultPadding, 5, kDefaultPadding, 5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              //color: Colors.white.withOpacity(0.3),
                              //borderRadius: BorderRadius.all(Radius.circular(10)),),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.done_rounded,
                                              color: Colors.purple,
                                              size: 30.0,
                                            ),
                                            Obx(
                                              () => Text(
                                                ' ${questionController.correct.value} ',
                                                style: const TextStyle(color: Colors.black87, fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(margin: const EdgeInsets.only(left: 10), child: const CircularCooldown()),
                                    Obx(
                                      () => Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.favorite_rounded,
                                            color: Colors.red,
                                          ),
                                          Icon(
                                            Icons.favorite_rounded,
                                            color: questionController.wrong.value < 2 ? Colors.red : Colors.grey,
                                          ),
                                          Icon(
                                            Icons.favorite_rounded,
                                            color: questionController.wrong.value == 0 ? Colors.red : Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 30,
                          child: Container(
                            width: double.infinity,
                            //height: double.infinity,
                            child: PageView.builder(
                              //block swiping
                              physics: const NeverScrollableScrollPhysics(),
                              controller: questionController.pageController,
                              onPageChanged: questionController.updateTheQnNum,
                              itemCount: questionController.pSurvivalQuestions!.length,
                              itemBuilder: (context, index) => QuestionCard(
                                  question:
                                      questionController.pSurvivalQuestions![index]), // sending question name via constructor
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 4 / 5,
                    right: 0,
                    bottom: 0,
                    top: MediaQuery.of(context).size.height * 6 / 7,
                    child: Obx(
                      () => Visibility(
                        visible: questionController.isVisible.value,
                        child: Center(
                          child: InkWell(
                            // provides clickable and cool click animation
                            onTap: () {
                              questionController.survivalNextQuestion();
                              questionController.alreadyAnswered = false;
                              cooldownController.restart();
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              //margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  gradient: kPrimaryGradient, borderRadius: BorderRadius.all(Radius.circular(50))),
                              child: const Icon(Icons.skip_next),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
