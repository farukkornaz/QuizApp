import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // core get package
import 'package:quiz_test_app/components/drawer_view.dart';
import 'package:quiz_test_app/components/quiz_card.dart';
import 'package:quiz_test_app/constants.dart'; // custom constants class
import 'package:quiz_test_app/controllers/auth_controller.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';
//import 'package:quiz_test_app/controllers/refresh_user_info_controller.dart';
import 'package:quiz_test_app/controllers/slider_controller.dart';
import 'package:quiz_test_app/models/Question.dart';
import 'package:quiz_test_app/screens/CategoryScreen.dart';
import 'package:quiz_test_app/screens/survival_quiz_screen.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../controllers/category_screen_controller/category_screen_controller.dart';
import '../controllers/glow_animation.dart';
import '../models/Quiz.dart';
import '../models/category_model.dart';
import 'error_screens/not_found_screen.dart';

class WelcomeScreen extends GetWidget<AuthController> {
  WelcomeScreen({super.key});

  CategoryScreenController categoryScreenController =
      Get.put(CategoryScreenController());
  late final List<CategoryModel> categories;

  Future<List<CategoryModel>> _fetchCategories() async {
    var categories = await categoryScreenController.getCategories();
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    SliderController sliderController = Get.put(SliderController());
    //AuthController authController = Get.put(AuthController());
    QuestionController questionController = Get.put(QuestionController());
    //RefreshUserController _rucontroller = Get.put(RefreshUserController());
    sliderController.BContext.value = MediaQuery.of(context).size.width;
    //var size = MediaQuery.of(context).size;
    /*if(!authController.guest){
      QuizController _quizController = Get.put(QuizController());// injection and trigger onInıt
    }*/
    return PopScope(
      canPop: false,
      child: Scaffold(
        drawer: const DrawerView(),
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          title: const Text(
            'Ana Sayfa',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
        ), // most common app layout
        body: FutureBuilder(
          future: _fetchCategories(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("hata"),
              );
            } else {
              List<CategoryModel> snapshotData = snapshot.data;
              return Container(
                color: kLightPurple,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Slider *********************************************************
                      Obx(
                        () => Stack(children: [
                          CarouselSlider(
                            items: sliderController.imageSliders,
                            options: CarouselOptions(
                                autoPlayInterval: const Duration(seconds: 15),
                                viewportFraction: 1,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 1.75,
                                onPageChanged: (index, reason) {
                                  sliderController.current.value = index;
                                }),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: sliderController.imgAList.map((url) {
                                int index =
                                    sliderController.imgAList.indexOf(url);
                                return Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        sliderController.current.value == index
                                            ? Colors.purple
                                            : Colors.white,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ]),
                      ),
                      //Kategoriler ve testleri ****************************************
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(CategoryScreen());
                            },
                            child: const Text("Kategoriler"),
                          ),
                        ),
                      ),
                      // Survival Questions *********************************************
                      Expanded(
                        child: ResponsiveGridList(
                          horizontalGridMargin: 10,
                          verticalGridMargin: 10,
                          minItemWidth: 150,
                          children: List.generate(
                            snapshotData.length,
                            (index) => GestureDetector(
                              onTap: () {
                                if (snapshotData[index].id != null) {
                                  categoryScreenController.goCategoryQuizzes(
                                      snapshotData[index].id!);
                                } else {
                                  Get.to(const NotFound());
                                }
                              },
                              child: Container(
                                //decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(20)),
                                padding: EdgeInsets.symmetric(
                                    vertical: kDefaultPadding),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  elevation: 4.0,
                                  child: Container(
                                    width: 200,
                                    height: 150,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 110, // Kartın %80'i
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(16.0),
                                              topRight: Radius.circular(16.0),
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  '${snapshotData[index].imagePath}'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.greenAccent,
                                          width: double.infinity,
                                          height: 40, // Kartın %20'si
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${snapshotData[index].name}',
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                /*Container(
                                  height: 150,
                                  width: 150,
                                  padding:
                                      const EdgeInsets.all(kDefaultPadding / 2),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.greenAccent,
                                    //color: Colors.white.withOpacity(0.3),
                                    //borderRadius: BorderRadius.all(Radius.circular(10)),),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                  ),
                                  child: Center(
                                    child: Text(
                                            '${snapshotData[index].name}',
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                                color: Colors.purple,
                                                fontSize: 22),
                                          ),
                                  ),
                                ),*/
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class CategorySample extends StatelessWidget {
  const CategorySample({super.key, required this.quiz});

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    QuestionController questionController = Get.put(QuestionController());
    return Container(
      width: 155,
      height: 300,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              quiz.name ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20, color: Colors.purple, fontFamily: 'Quicksand'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //TODO: kazanılan yıldızlar kullanıcıdan al
          /*Container(
              width: 155,
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (_controller.quizesScores[
                                _controller.quizes[index].id! - 1] >
                            0)
                        ? const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          )
                        : const Icon(
                            Icons.star_border,
                            color: Colors.grey,
                          ),
                    (_controller.quizesScores[
                                _controller.quizes[index].id! - 1] >
                            1)
                        ? const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          )
                        : const Icon(
                            Icons.star_border,
                            color: Colors.grey,
                          ),
                    (_controller.quizesScores[
                                _controller.quizes[index].id! - 1] >
                            2)
                        ? const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          )
                        : const Icon(
                            Icons.star_border,
                            color: Colors.grey,
                          ),
                  ],
                ),
              )),*/
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              questionController.activeQuizId = quiz.id;
              await questionController
                  .getTheRightQuestions("S1YRgOThEUkE5IWPNQ0i");
              questionController.getQuizScreen();
            },
            child: Container(
              height: 140,
              width: 180,
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                border: Border.all(
                  color: Colors.deepOrange,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      quiz.name!,
                      style: const TextStyle(
                          fontSize: 20, fontFamily: 'Swissblack'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Text('Category *')
        ],
      ),
    );
  }
}
