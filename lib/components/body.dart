import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/components/progress_bar.dart'; // custom progress bar widget
import 'package:quiz_test_app/components/question_card.dart'; // custom question card widget
import 'package:quiz_test_app/constants.dart';
import 'package:quiz_test_app/controllers/question_controller.dart'; // custom question controller class

class Body extends StatelessWidget {
  Body({super.key});

  //final QuestionController _questionController = Get.put(QuestionController());
  final QuestionController _questionController = Get.find<QuestionController>();

  @override
  Widget build(BuildContext context) {
    //accessing controller

    return Scaffold(
      backgroundColor: Colors.purple,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
          color: kLightPurple,
          child: Stack(
            children: [
              /*WebsafeSvg.asset(
                'assets/icons/bg.svg',
                fit: BoxFit.fill,
              ),*/
              Container(
                  height: 185,
                  decoration: const BoxDecoration(
                    color: Colors.purple,
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
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                            _questionController.questReset();
                            _questionController.resetStatus();
                            _questionController.alreadyAnswered = false;
                          },
                          child: Container(
                            width: 26,
                            height: 26,
                            margin: const EdgeInsets.fromLTRB(0, 0, 5, 5),
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
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Stack(children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, 0),
                          padding: const EdgeInsets.fromLTRB(kDefaultPadding, kDefaultPadding, kDefaultPadding, 0),
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
                                    children: [
                                      SizedBox(
                                        width: 43,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.done_rounded,
                                              color: kGreenColor,
                                              size: 20.0,
                                            ),
                                            Obx(
                                              () => Text(
                                                ' ${_questionController.correct.value} ',
                                                style: const TextStyle(color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 43,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.close_rounded,
                                              color: kRedColor,
                                              size: 20.0,
                                            ),
                                            Obx(
                                              () => Text(
                                                ' ${_questionController.wrong.value} ',
                                                style: const TextStyle(color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 43,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.skip_next_rounded,
                                              color: Colors.black87,
                                              size: 20.0,
                                            ),
                                            Obx(
                                              () => Text(
                                                ' ${_questionController.skipped} ',
                                                style: const TextStyle(color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Obx(
                                          // Obx provides changeable variables in stateless
                                          () => Text.rich(
                                            TextSpan(
                                              text: '${_questionController.questionNumber.value}',
                                              style: Theme.of(context).textTheme.headlineSmall,
                                              children: [
                                                TextSpan(
                                                    text: '/${_questionController.questionss?.length}    ',
                                                    style: Theme.of(context).textTheme.titleLarge),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          'Puan : ',
                                          style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
                                        ),
                                        //SizedBox(height: 10),
                                        Obx(
                                          () => Text(
                                            '${_questionController.score}',
                                            style: const TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Center(
                                child: ProgressBar(),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                    Expanded(
                      flex: 30,
                      child: SizedBox(
                        width: double.infinity,
                        //height: double.infinity,
                        child: PageView.builder(
                          //block swiping
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _questionController.pageController,
                          onPageChanged: _questionController.updateTheQnNum,
                          itemCount: _questionController.questionss?.length,
                          itemBuilder: (context, index) => QuestionCard(
                              question: _questionController.questionss![index]), // sending question name via constructor
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
                    visible: _questionController.isVisible.value,
                    child: Center(
                      child: InkWell(
                        // provides clickable and cool click animation
                        onTap: () {
                          _questionController.nextQuestion();
                          _questionController.alreadyAnswered = false;
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
    );
  }
}
