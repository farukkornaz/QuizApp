import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/auth_controller.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';
import 'package:quiz_test_app/services/database.dart';

class OnlineStatusController extends GetxController with WidgetsBindingObserver{
  AuthController _authController = Get.find<AuthController>();
  QuestionController _controller = Get.find<QuestionController>();
  onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.paused){
      if(_authController.user?.uid != "Ol6dYajUz2VkQT6GSoTBYnDbOQ13"){
        _controller.checkOnlineAnswers();
        await Database().storeOnlineExam(_controller.onlineTestName, _controller.numOfCorrectAns,
            (_controller.timerMinute.value * 60) +
                _controller.timerStart.value,
            _authController.user?.email ?? '');
      }else{
        print(_controller.onlineTestName);
        print(_controller.numOfCorrectAns);
        print((_controller.timerMinute.value * 60) +
            _controller.timerStart.value);
      }
      _controller.questReset();
      _controller.resetStatus();
      _controller.onlineSelectedReset();
      _controller.resetOnlineTimer();
      _controller.isVisible.value = false;
    }
  }
}