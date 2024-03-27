import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/auth_controller.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';
import 'package:quiz_test_app/controllers/quiz_controller.dart';
import 'package:quiz_test_app/controllers/user_controller.dart';

class AuthBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<QuizController>(() => QuizController());
    Get.lazyPut<QuestionController>(() => QuestionController());
    Get.lazyPut<UserController>(() => UserController());
  }
}