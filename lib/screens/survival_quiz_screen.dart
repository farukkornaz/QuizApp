import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/components/circular_cooldown.dart';
import 'package:quiz_test_app/components/question_card.dart';
import 'package:quiz_test_app/controllers/cooldown_controller.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';

import '../constants.dart'; // question controller class

class SurvivalQuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.find<QuestionController>();
    //QuestionController _controller = Get.put(QuestionController());
    CooldownControl _ccontroller = Get.put(CooldownControl());
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
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        //color: Colors.white.withOpacity(0.3),
                        //borderRadius: BorderRadius.all(Radius.circular(10)),),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(kDefaultPadding, 0, 0, 0),
                                child: Obx(() => _controller.survHigh.value <
                                        _controller.survivalScores[
                                            (int.tryParse((_controller.activeSurvivalQuiz?.substring(5, 6)) ?? '') ??
                                                    0) -
                                                1]
                                    ? Text(
                                        "En Yüksek Skor : ${_controller.survivalScores[(int.tryParse(_controller.activeSurvivalQuiz?.substring(5, 6) ?? '') ?? 0) - 1]}",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : Text(
                                        "En Yüksek Skor : ${_controller.survHigh.value}",
                                        style: TextStyle(color: Colors.white),
                                      )),
                              ),
                              InkWell(
                                // provides clickable and cool click animation
                                onTap: () {
                                  Get.back();
                                  _controller.questReset();
                                  _controller.resetStatus();
                                  _controller.survivalActive = false;
                                  _controller.alreadyAnswered = false;
                                },
                                child: Container(
                                  width: 26,
                                  height: 26,
                                  margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  alignment: Alignment.center,
                                  //padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent, borderRadius: BorderRadius.all(Radius.circular(25))),
                                  child: Icon(
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
                            margin: EdgeInsets.fromLTRB(kDefaultPadding, 5, kDefaultPadding, 0),
                            padding: EdgeInsets.fromLTRB(kDefaultPadding, 5, kDefaultPadding, 5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              //color: Colors.white.withOpacity(0.3),
                              //borderRadius: BorderRadius.all(Radius.circular(10)),),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
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
                                            Icon(
                                              Icons.done_rounded,
                                              color: Colors.purple,
                                              size: 30.0,
                                            ),
                                            Obx(
                                              () => Text(
                                                ' ${_controller.correct.value} ',
                                                style: TextStyle(color: Colors.black87, fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(margin: EdgeInsets.only(left: 10), child: CircularCooldown()),
                                    Obx(
                                      () => Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.favorite_rounded,
                                            color: Colors.red,
                                          ),
                                          Icon(
                                            Icons.favorite_rounded,
                                            color: _controller.wrong.value < 2 ? Colors.red : Colors.grey,
                                          ),
                                          Icon(
                                            Icons.favorite_rounded,
                                            color: _controller.wrong.value == 0 ? Colors.red : Colors.grey,
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
                              physics: NeverScrollableScrollPhysics(),
                              controller: _controller.pageController,
                              onPageChanged: _controller.updateTheQnNum,
                              itemCount: _controller.pSurvivalQuestions!.length,
                              itemBuilder: (context, index) => QuestionCard(
                                  question:
                                      _controller.pSurvivalQuestions![index]), // sending question name via constructor
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
                    child: Container(
                      child: Obx(
                        () => Visibility(
                          visible: _controller.isVisible.value,
                          child: Center(
                            child: InkWell(
                              // provides clickable and cool click animation
                              onTap: () {
                                _controller.survivalNextQuestion();
                                _controller.alreadyAnswered = false;
                                _ccontroller.restart();
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                //margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    gradient: kPrimaryGradient, borderRadius: BorderRadius.all(Radius.circular(50))),
                                child: Icon(Icons.skip_next),
                              ),
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
