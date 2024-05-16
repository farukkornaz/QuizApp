import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
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

import '../controllers/glow_animation.dart';
import '../models/Quiz.dart';

class WelcomeScreen extends GetWidget<AuthController> {
  const WelcomeScreen({super.key});

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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text(
            'Ana Sayfa',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
        ), // most common app layout
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SafeArea(
                child: Container(
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
                                  autoPlayInterval:
                                      const Duration(seconds: 15),
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
                        //populer  *******************************************************
                        Column(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10),
                                          child: const Center(
                                              child: Text(
                                            'Popüler Quizler',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.purple),
                                          )),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                          height: 130,
                                          width: double.infinity,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: questionController
                                                    .popularQuizes?.length ??
                                                0,
                                            itemBuilder: (context, index) =>
                                                QuizCard(
                                                    quizes: questionController
                                                        .popularQuizes![index]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: kDefaultPadding),
                                child: ExpandableNotifier(
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                        kDefaultPadding / 2),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.white,
                                      //color: Colors.white.withOpacity(0.3),
                                      //borderRadius: BorderRadius.all(Radius.circular(10)),),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                    child: Column(
                                      children: [
                                        Expandable(
                                          collapsed: ExpandableButton(
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '  Matematik',
                                                  style: TextStyle(
                                                      color: Colors.purple,
                                                      fontSize: 18),
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_downward_rounded,
                                                  color: Colors.purple,
                                                ),
                                              ],
                                            ),
                                          ),
                                          expanded: Column(children: [
                                            const Text(
                                              'Matematik Testleri',
                                              style: TextStyle(
                                                  color: Colors.purple,
                                                  fontSize: 25),
                                            ),
                                            const Divider(
                                              color: Colors.purple,
                                              thickness: 2,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(
                                                  kDefaultPadding),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(10)),
                                              ),
                                              child: Column(
                                                children: [
                                                  CategorySample(
                                                      quiz: Quiz(
                                                          id: "S1YRgOThEUkE5IWPNQ0i",
                                                          name: "Fizik",
                                                          questions: [
                                                        Question(
                                                            id: 1,
                                                            answerIndex: 2,
                                                            options: [
                                                              "1",
                                                              "2",
                                                              "3",
                                                              "4"
                                                            ],
                                                            question:
                                                                "vecap nedire?"),
                                                        Question(
                                                            id: 2,
                                                            answerIndex: 2,
                                                            options: [
                                                              "1",
                                                              "2",
                                                              "3",
                                                              "4"
                                                            ],
                                                            question:
                                                                "cevap nedir?")
                                                      ])),
                                                  /*CategorySample(index: 1),
                                                  CategorySample(index: 2),
                                                  CategorySample(index: 3),*/
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: Colors.white,
                                              child: ExpandableButton(
                                                // <-- Collapses when tapped on
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '  Matematik',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.purple,
                                                          fontSize: 18),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_upward_rounded,
                                                      color: Colors.purple,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Survival Questions *********************************************
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              questionController.survivalActive = true;
                              questionController.survHigh.value = 0;
                              /*_controller
                                  .getTheRightSurvivalQuestions("surv_3");*/
                              Get.to(const SurvivalQuizScreen());
                            },
                            child: GetBuilder<GlowAnimationController>(
                                init: GlowAnimationController(),
                                builder: (controller) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        color: Colors.purple,
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius:
                                                  controller.animation.value,
                                              blurRadius:
                                                  controller.animation.value,
                                              color: Colors.purple
                                                  .withOpacity(0.8))
                                        ]),
                                    height: 35,
                                    width: 225,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Hayatta Kalma Modu',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Icon(Icons.access_time_rounded),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
              await questionController.getTheRightQuestions("S1YRgOThEUkE5IWPNQ0i");
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
