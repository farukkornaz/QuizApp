import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';

import '../constants.dart';

class OnlineScoreScreen extends StatelessWidget {
  const OnlineScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(kDefaultPadding),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 40,),
              Container(
                height: 250,
                  child: Image(image: AssetImage("assets/images/baloons.jpeg"),
                  )
              ),
              Column(
                children: [
                  Text("TEBRİKLER !",style: TextStyle(color: Colors.purple,fontSize: 22)),
                  SizedBox(height: 25,),
                  Text("Sınavı başarıyla tamamladınız",style: TextStyle(color: Colors.grey[600],fontSize: 17)),
                ],
              ),
              SizedBox(height: 25,),
              InkWell( // provides clickable and cool click animation
                onTap: (){
                  _controller.onlineActive = false;
                  Get.back();

                }, // Get package easy navigate function
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(kDefaultPadding),
                  decoration: BoxDecoration(
                      gradient: kPrimaryGradient,
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child: AutoSizeText(
                      'Ana Sayfası',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white,fontSize: 17)),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
