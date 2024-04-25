import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/cooldown_controller.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';
import 'package:quiz_test_app/models/Question.dart';

import '../constants.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    //we have to pass this
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    CooldownControl _cooldown = Get.put(CooldownControl());
    return Column(
      children: [
        Expanded(
          flex: 10,
          child: Center(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  /*constraints: BoxConstraints(
                    minHeight: 150, minWidth: double.infinity, maxHeight: 150),*/
                  margin: const EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, 3),
                  padding: const EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, kDefaultPadding / 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: _controller.onlineActive
                        ? BorderRadius.circular(10)
                        : const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.15),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Center(
                      child: AutoSizeText(
                        question.question ?? '',
                        textAlign: question.question?.contains("I)") ?? false ? TextAlign.start : TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                        //style: Theme.of(context).textTheme.headline6.copyWith(color: kBlackColor),
                        /*style: Theme.of(context).textTheme.headline5
                          .copyWith(color: Colors.black87),*/
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: getWidget(_controller.onlineActive, question.question!),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 12,
          child: Container(
            margin: const EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, 0),
            /*margin: EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
            padding: EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25)
            ),*/
            child: Column(
              children: [
                const SizedBox(
                  height: kDefaultPadding / 2,
                ),
                ...List.generate(
                  // ... spread operator for showing list elements in list
                  question.options?.length ?? 0,
                  (index) => Option(
                    index: index,
                    text: question.options?[index],
                    press: () {
                      if (_controller.onlineActive) {
                        _controller.onlineAnswered(question, index);
                        //_controller.newOnlineSelectedValue(question.id!, index);
                      } else {
                        _controller.checkAns(question, index);
                        _controller.alreadyAnswered = true;
                        if (_controller.survivalActive) {
                          _cooldown.pause();
                          _controller.survivalEndCheck();
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        )
      ],
    );
  }

  Widget getWidget(bool x, String question) {
    if (x) {
      return Container(
        margin: const EdgeInsets.all(10),
        child: IconButton(
            onPressed: () => Get.defaultDialog(
                title: "Uzun sorularda aşağıya kaydırınız",
                content: SizedBox(
                  height: 390,
                  width: 300,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Text(
                        question,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          //alignment: Alignment.centerRight,
                          child: IconButton(
                              onPressed: () => Get.back(),
                              icon: const Icon(
                                Icons.zoom_out_rounded,
                                color: Colors.purple,
                                size: 40,
                              ))),
                    ]),
                  ),
                )),
            icon: const Icon(
              Icons.zoom_in_rounded,
              color: Colors.purple,
              size: 30,
            )),
      );
    } else {
      return Container(
        height: 1,
      );
    }
  }
}
