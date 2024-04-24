import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';
import '../constants.dart';


class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 10,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white,width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: GetBuilder<QuestionController>( // builder of Get package for updating data
        init: QuestionController(),
          builder: (controller) {
         // print(controller.animation.value);
          return Stack(
            children: [
              //Layout builder provide space for container
              LayoutBuilder(builder: (context , constraints) => Container(
                width: constraints.maxWidth * controller.animation.value,
                decoration: BoxDecoration(
                  gradient:kCooldownGradient,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              ),
              const Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
                  /*child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${(controller.animation.value * 60).round()} Saniye'),
                      WebsafeSvg.asset('assets/icons/clock.svg'),
                    ],
                  ),*/
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}