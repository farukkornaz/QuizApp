import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';
import 'package:quiz_test_app/screens/online_quiz_screen.dart';

import '../services/database.dart';

class OnlineWaitingScreen extends StatelessWidget {




  QuestionController _questionController = Get.put(QuestionController());
  Database database = Database();

  late Stream<DocumentSnapshot<Map<String, dynamic>>> stream;

  initState() {
    var db = Database();
    stream = db.listenAdminForChangeOfNextOrPreviousQuestion();
  }

  @override
  Widget build(BuildContext context) {
    initState();
    return Scaffold(
      body: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return const Text("birşeyler olmadı :/");
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Text("yükleniyor");
          }
          var data = snapshot.requireData.data();
          if(data?["start"]){
            WidgetsBinding.instance.addPostFrameCallback((_){
              database.resetOnlineStarter();
              _questionController.onlineActive = true;
              _questionController.isVisible.value = true;
              _questionController.startTimer();
              //Get.to(OnlineQuizScreen());
              Get.back();
              Get.to(OnlineQuizScreen());
            });

          }
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: Image.asset("assets/images/app_logo.png"),),
                  Text("lütfen yönetici sınavı"),
                  Text("başlatana kadar bekleyiniz."),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
