import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/auth_controller.dart';
import 'package:quiz_test_app/controllers/user_controller.dart';
import 'package:quiz_test_app/screens/login.dart';
import 'package:quiz_test_app/screens/welcome_screen.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    /*return GetX(
        initState: (_)async{
          Get.put<UserController>(UserController());
        },
        builder: (_){
      if(Get.find<AuthController>().user?.uid != null){
        return WelcomeScreen();
      }else{
        return Login();
      }
    }
    ); */

     return Obx((){
      return (Get.find<AuthController>().user != null)? WelcomeScreen():Login();
    });

  }
}
