import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:quiz_test_app/controllers/quiz_controller.dart';
import '../../models/Quiz.dart';
import '../../screens/quizzes_screen.dart';
import '../../screens/welcome_screen.dart';
import '../../services/database.dart';
import 'package:quiz_test_app/models/category_model.dart';

class CategoryScreenController extends GetxController {
  late List<CategoryModel> categories;
  Database database = Database();

  Future<List<CategoryModel>> getCategories() async {
    categories = await database.getCategories();
    return categories;
  }

  void goCategoryQuizzes(String categoryId) async{
    List<Quiz> quizzes = await database.getQuizesByCategory(categoryId);
    QuizController quizController = QuizController();
    Get.to(QuizzesScreen(quizzes));

  }
}


