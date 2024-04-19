import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';

import '../constants.dart';

class Option extends StatelessWidget {
  Option({
    super.key,
    this.text,
    this.index,
    this.press,
    this.qid,
    this.selected,
  });

  final String? text;
  final int? index;
  final VoidCallback? press;
  final int? qid;
  late final int? selected;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qnController) {
          Color getTheRightColor() {
            if (qnController.onlineActive) {
              selected = qnController.selectedOnlineAnswers[(qid ?? 0) - 1];
              if (selected != -1) {
                if (index == selected) {
                  return Colors.black87;
                } else {
                  return Colors.grey.shade300;
                }
              }
            } else if (qnController.isAnswered) {
              if (index == qnController.correctAns) {
                return kGreenColor;
              } else if (index == qnController.selectedAns && qnController.selectedAns != qnController.correctAns) {
                return kRedColor;
              }
            }
            return Colors.grey.shade300;
          }

          IconData? getTheRightIcon() {
            if (qnController.onlineActive) {
              return getTheRightColor() == Colors.black87 ? Icons.star : null;
            } else
              return getTheRightColor() == kRedColor ? Icons.close : Icons.done;
          }

          return Expanded(
            child: InkWell(
              onTap: press,
              child: Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: getTheRightColor(), width: 2),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        color: getTheRightColor() == Colors.grey[350] ? Colors.transparent : getTheRightColor(),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: getTheRightColor()),
                      ),
                      child: getTheRightColor() == Colors.grey[350] ? null : Icon(getTheRightIcon(), size: 10),
                    ),
                    /*Text(
                    //'${index + 1}.',
                    '${String.fromCharCode(0x41 + index)} )   ',
                    style: TextStyle(color: getTheRightColor(), fontSize: 15),
                  ),*/
                    Container(
                      width: MediaQuery.of(context).size.width * 2 / 3,
                      child: Center(
                        child: AutoSizeText(
                          '$text',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black87, fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
