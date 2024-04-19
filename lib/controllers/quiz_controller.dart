import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/auth_controller.dart';
import 'package:quiz_test_app/models/quiz_DB.dart';
import 'package:quiz_test_app/services/database.dart';

class QuizController extends GetxController {
  //class for getting and binding quiz list DB <-> local variable
  RxList<QuizModel> quizList = RxList<QuizModel>(); // Rx because update with every change

  List<QuizModel> get quizInfo => quizList;

  @override
  void onInit() {
    super.onInit();
    String uid = Get.find<AuthController>().user!.uid;
    quizList.bindStream(Database().quizStream(uid)); // binding our list to database
  }
}
