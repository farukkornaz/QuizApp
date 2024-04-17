import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/components/question_card.dart';
import 'package:quiz_test_app/controllers/auth_controller.dart';
import 'package:quiz_test_app/controllers/online_status_controller.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';
import 'package:quiz_test_app/services/database.dart';

import '../constants.dart';
import 'online_score_screen.dart'; // question controller class

class OnlineQuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    AuthController _aController = Get.find<AuthController>();
    OnlineStatusController _osc = Get.put(OnlineStatusController());
    _controller.onInit();

    return PopScope(
      canPop: false,
      child: SafeArea(
        top: false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.purple,
          body: SafeArea(
            child: Container(
              color: kLightPurple,
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
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              // provides clickable and cool click animation
                              onTap: () async {
                                if (_aController.user?.uid == "TbTq1loYiUcCbSsTgcQp90nKS2c2") {
                                  _controller.checkOnlineAnswers();
                                  print(_controller.numOfCorrectAns);
                                  _controller.questReset();
                                  _controller.resetStatus();
                                  _controller.onlineActive = false;
                                  _controller.onlineSelectedReset();
                                  _controller.resetOnlineTimer();
                                  _controller.isVisible.value = false;
                                  Get.off(OnlineScoreScreen());
                                } else {
                                  _controller.checkOnlineAnswers();
                                  try {
                                    await Database().storeOnlineExam(
                                      _controller.onlineTestName,
                                      _controller.numOfCorrectAns,
                                      (_controller.timerMinute.value * 60) + _controller.timerStart.value,
                                      _aController.user?.email ?? "email bulunamadı",
                                    );
                                  } catch (e) {
                                    Get.snackbar(
                                      'Error',
                                      e.toString(),
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.purpleAccent.withOpacity(0.5),
                                      colorText: Colors.white,
                                      borderColor: Colors.purpleAccent,
                                      borderWidth: 1.5,
                                      isDismissible: true,
                                      icon: Icon(
                                        Icons.error_outline_rounded,
                                        color: Colors.white,
                                      ),
                                      shouldIconPulse: false,
                                    );
                                  }
                                  _aController.onlineExamChecker = 1;
                                  _controller.questReset();
                                  _controller.resetStatus();
                                  _controller.onlineActive = false;
                                  _controller.onlineSelectedReset();
                                  _controller.resetOnlineTimer();
                                  _controller.isVisible.value = false;
                                  Get.off(OnlineScoreScreen());
                                }
                              },
                              child: Container(
                                width: 59,
                                height: 26,
                                margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                alignment: Alignment.center,
                                //padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.redAccent, borderRadius: BorderRadius.all(Radius.circular(25))),
                                child: Text(
                                  "Testi Bitir",
                                  style: TextStyle(fontSize: 11, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, 0),
                              width: double.infinity,
                              /*decoration: BoxDecoration(
                          color: Colors.white,
                          //color: Colors.white.withOpacity(0.3),
                          //borderRadius: BorderRadius.all(Radius.circular(10)),),
                          borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight:Radius.circular(10),),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),*/
                              child: Obx(() => Container(
                                    margin: EdgeInsets.fromLTRB(17, 0, 17, 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.timer_rounded,
                                              size: 20,
                                              color: Colors.white70,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "${_controller.timerMinute.value.toString().padLeft(2, '0')} "
                                              ": ${_controller.timerStart.value.toString().padLeft(2, '0')}",
                                              style: TextStyle(fontSize: 15, color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Obx(
                                          // Obx provides changeable variables in stateless
                                          () => Text.rich(
                                            TextSpan(
                                              text: _controller.questionNumber.value >
                                                      (_controller.databaseQuestions?.length ?? 0)
                                                  ? '${_controller.databaseQuestions?.length}'
                                                  : '${_controller.questionNumber.value}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .copyWith(color: Colors.white),
                                              children: [
                                                TextSpan(
                                                  text: '/${_controller.databaseQuestions?.length ?? 0}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .copyWith(color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            )),
                        Expanded(
                          flex: 30,
                          child: Container(
                            width: double.infinity,
                            //height: double.infinity,
                            child: PageView.builder(
                                //physics: NeverScrollableScrollPhysics(),//block swiping
                                controller: _controller.pageController,
                                onPageChanged: _controller.updateTheQnNum,
                                itemCount: (_controller.databaseQuestions?.length ?? 0) + 1,
                                itemBuilder: (context, index) {
                                  if (index == (_controller.databaseQuestions?.length ?? 0)) {
                                    return Container(
                                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Column(
                                          children: [
                                            Container(
                                                height: 200,
                                                child: Image(
                                                  image: AssetImage("assets/images/student.jpg"),
                                                  fit: BoxFit.fill,
                                                )),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            //Text("TEBRİKLER",style: TextStyle(color: Colors.purple[800],fontSize: 30),),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "Yarışmayı başarıyla bitirdiniz 😊",
                                              style: TextStyle(color: Colors.grey[600], fontSize: 17),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "İsterseniz sorularınıza geri dönerek",
                                              style: TextStyle(color: Colors.grey[600], fontSize: 17),
                                            ),
                                            Text(
                                              "kontrol edebilir veya testi bitirebilirsiniz.",
                                              style: TextStyle(color: Colors.grey[600], fontSize: 17),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              // provides clickable and cool click animation
                                              onTap: () async {
                                                if (_aController.user?.uid == "Ol6dYajUz2VkQT6GSoTBYnDbOQ13") {
                                                  _controller.checkOnlineAnswers();
                                                  /*Get.back();
                                                Get.defaultDialog(
                                                    content: Column(
                                                      children: [
                                                        Text("Doğru Sayısı = ${_controller.numOfCorrectAns}"),
                                                        Text(""),
                                                        Text("Süre = ${(_controller.timerMinute.value * 60) +
                                                            _controller.timerStart.value} Saniye")
                                                      ],
                                                    )
                                                );*/
                                                  print(_controller.numOfCorrectAns);
                                                  _controller.questReset();
                                                  _controller.resetStatus();
                                                  _controller.onlineSelectedReset();
                                                  _controller.resetOnlineTimer();
                                                  _controller.isVisible.value = false;
                                                  Get.off(OnlineScoreScreen());
                                                } else {
                                                  _controller.checkOnlineAnswers();
                                                  try {
                                                    await Database().storeOnlineExam(
                                                        _controller.onlineTestName,
                                                        _controller.numOfCorrectAns,
                                                        (_controller.timerMinute.value * 60) +
                                                            _controller.timerStart.value,
                                                        _aController.user?.email ?? "email bulunamadı");
                                                  } catch (e) {
                                                    Get.snackbar(
                                                      'Error',
                                                      e.toString(),
                                                      snackPosition: SnackPosition.BOTTOM,
                                                      backgroundColor: Colors.purpleAccent.withOpacity(0.5),
                                                      colorText: Colors.white,
                                                      borderColor: Colors.purpleAccent,
                                                      borderWidth: 1.5,
                                                      isDismissible: true,
                                                      icon: Icon(
                                                        Icons.error_outline_rounded,
                                                        color: Colors.white,
                                                      ),
                                                      shouldIconPulse: false,
                                                    );
                                                  }
                                                  _aController.onlineExamChecker = 1;
                                                  _controller.questReset();
                                                  _controller.resetStatus();
                                                  _controller.onlineSelectedReset();
                                                  _controller.resetOnlineTimer();
                                                  _controller.isVisible.value = false;
                                                  Get.off(OnlineScoreScreen());
                                                }
                                              },
                                              child: Container(
                                                width: 200,
                                                height: 50,
                                                margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                                alignment: Alignment.center,
                                                //padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(color: Colors.purple.shade800, width: 3),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(25),
                                                  ),
                                                ),
                                                child: Text(
                                                  "Testi Bitir",
                                                  style: TextStyle(fontSize: 22, color: Colors.purple[800]),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            //color: Colors.white.withOpacity(0.3),
                                            //borderRadius: BorderRadius.all(Radius.circular(10)),),
                                            borderRadius: BorderRadius.all(Radius.circular(20))));
                                  } else
                                    return QuestionCard(question: _controller.databaseQuestions![index]);
                                }
                                // sending question name via constructor
                                ),
                          ),
                        ),
                        /*Expanded(
                        flex:3,
                        child: Obx(() =>Visibility(
                          visible: _questionController.isVisible.value,
                          child:Center(
                            child: InkWell( // provides clickable and cool click animation
                              onTap: () {
                                _questionController.nextQuestion();
                                _questionController.alreadyAnswered = false;
                              },
                              child: Container(
                                width: 100,
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    gradient: kPrimaryGradient,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child:Text(
                                    _questionController.nextQText.value,
                                    style: Theme.of(context).textTheme.button.copyWith(color: Colors.white, fontSize: 14)),
                              ),
                            ),
                          ),
                        ),
                        ),
                      ),*/
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Container(
                                child: Center(
                                  child: InkWell(
                                    // provides clickable and cool click animation
                                    onTap: () {
                                      _controller.onlinePreviousQuestion();
                                    },
                                    child: Container(
                                      width: 75,
                                      height: 25,
                                      margin: EdgeInsets.only(left: 7.5),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          gradient: kPrimaryGradient,
                                          borderRadius: BorderRadius.all(Radius.circular(25))),
                                      child: Icon(
                                        Icons.arrow_back_rounded,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: InkWell(
                                    // provides clickable and cool click animation
                                    onTap: () {
                                      _controller.onlineNextQuestion();
                                    },
                                    child: Container(
                                      width: 75,
                                      height: 25,
                                      margin: EdgeInsets.only(right: 7.5),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          gradient: kPrimaryGradient,
                                          borderRadius: BorderRadius.all(Radius.circular(50))),
                                      child: Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        )
                      ],
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
