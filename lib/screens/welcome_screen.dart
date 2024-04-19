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
import 'package:quiz_test_app/screens/survival_quiz_screen.dart';

import '../controllers/glow_animation.dart';

class WelcomeScreen extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    SliderController sController = Get.put(SliderController());
    //AuthController authController = Get.put(AuthController());
    QuestionController _controller = Get.put(QuestionController());
    //RefreshUserController _rucontroller = Get.put(RefreshUserController());
    sController.BContext.value = MediaQuery.of(context).size.width;
    //var size = MediaQuery.of(context).size;
    /*if(!authController.guest){
      QuizController _quizController = Get.put(QuizController());// injection and trigger onInıt
    }*/
    return PopScope(
      canPop: false,
      child: Scaffold(
        drawer: DrawerView(),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          /*leading: IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              if(authController.guest)
              {
                Get.back();
                authController.guest = false;
              }
              else
                controller.signOut();
            },
          ),*/
          title: Text(
            'Ana Sayfa',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  _controller.resetLocalQuizesScore();
                },
                icon: Icon(Icons.refresh)),
          ],
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
                        Obx(
                          () => Container(
                            child: Stack(children: [
                              CarouselSlider(
                                items: sController.imageSliders,
                                options: CarouselOptions(
                                    autoPlayInterval: Duration(seconds: 15),
                                    viewportFraction: 1,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    aspectRatio: 1.75,
                                    onPageChanged: (index, reason) {
                                      sController.current.value = index;
                                    }),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: sController.imgAList.map((url) {
                                    int index =
                                        sController.imgAList.indexOf(url);
                                    return Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            sController.current.value == index
                                                ? Colors.purple
                                                : Colors.white,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        Column(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: Center(
                                              child: Text(
                                            'Popüler Quizler',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.purple),
                                          )),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(10, 0, 0, 10),
                                          height: 130,
                                          width: double.infinity,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: _controller
                                                    .popularQuizes?.length ??
                                                0,
                                            itemBuilder: (context, index) =>
                                                QuizCard(
                                                    quizes: _controller
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
                        Container(
                          margin: EdgeInsets.only(top: kDefaultPadding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: kDefaultPadding),
                                child: ExpandableNotifier(
                                  // <-- Provides ExpandableController to its children
                                  child: Container(
                                    padding:
                                        EdgeInsets.all(kDefaultPadding / 2),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.white,
                                      //color: Colors.white.withOpacity(0.3),
                                      //borderRadius: BorderRadius.all(Radius.circular(10)),),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Column(
                                      children: [
                                        Expandable(
                                          // <-- Driven by ExpandableController from ExpandableNotifier
                                          collapsed: ExpandableButton(
                                            // <-- Expands when tapped on the cover photo
                                            child: Row(
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
                                                  Icons.arrow_downward_rounded,
                                                  color: Colors.purple,
                                                ),
                                              ],
                                            ),
                                          ),
                                          expanded: Column(children: [
                                            Text(
                                              'Matematik Testleri',
                                              style: TextStyle(
                                                  color: Colors.purple,
                                                  fontSize: 25),
                                            ),
                                            Divider(
                                              color: Colors.purple,
                                              thickness: 2,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  kDefaultPadding),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: Column(
                                                children: [
                                                  CategorySample(index: 0),
                                                  CategorySample(index: 1),
                                                  CategorySample(index: 2),
                                                  CategorySample(index: 3),
                                                  /*Container(
                                                        width: 225,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            primary: Colors.purple,
                                                          ),
                                                          onPressed: () async{
                                                            _controller.survivalActive = true;
                                                            _controller.survHigh.value = 0;
                                                            _controller.getTheRightSurvivalQuestions("surv_1");
                                                            Get.to(SurvivalQuizScreen());
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text('Hayatta Kalma Modu',style: TextStyle(color: Colors.white,fontSize: 15),),
                                                              Icon(Icons.access_time_rounded),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10,)*/
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: Colors.white,
                                              child: ExpandableButton(
                                                // <-- Collapses when tapped on
                                                child: Row(
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
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: kDefaultPadding),
                                child: ExpandableNotifier(
                                  // <-- Provides ExpandableController to its children
                                  child: Container(
                                    padding:
                                        EdgeInsets.all(kDefaultPadding / 2),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.white,
                                      //color: Colors.white.withOpacity(0.3),
                                      //borderRadius: BorderRadius.all(Radius.circular(10)),),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Column(
                                      children: [
                                        Expandable(
                                          // <-- Driven by ExpandableController from ExpandableNotifier
                                          collapsed: ExpandableButton(
                                            // <-- Expands when tapped on the cover photo
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '  Genel Kültür',
                                                  style: TextStyle(
                                                      color: Colors.purple,
                                                      fontSize: 18),
                                                ),
                                                Icon(
                                                  Icons.arrow_downward_rounded,
                                                  color: Colors.purple,
                                                ),
                                              ],
                                            ),
                                          ),
                                          expanded: Column(children: [
                                            Text(
                                              'Genel Kültür Testleri',
                                              style: TextStyle(
                                                  color: Colors.purple,
                                                  fontSize: 25),
                                            ),
                                            Divider(
                                              color: Colors.purple,
                                              thickness: 2,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  kDefaultPadding),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: Column(
                                                children: [
                                                  CategorySample(index: 4),
                                                  CategorySample(index: 5),
                                                  /*Container(
                                                        width: 225,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            primary: Colors.purple,
                                                          ),
                                                          onPressed: (){
                                                            _controller.survivalActive = true;
                                                            _controller.survHigh.value = 0;
                                                            _controller.getTheRightSurvivalQuestions("surv_2");
                                                            Get.to(SurvivalQuizScreen());
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text('Hayatta Kalma Modu',style: TextStyle(color: Colors.white,fontSize: 15),),
                                                              Icon(Icons.access_time_rounded),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10,)*/
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: Colors.white,
                                              child: ExpandableButton(
                                                // <-- Collapses when tapped on
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '  Genel Kültür',
                                                      style: TextStyle(
                                                          color: Colors.purple,
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
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: kDefaultPadding),
                                child: ExpandableNotifier(
                                  // <-- Provides ExpandableController to its children
                                  child: Container(
                                    padding:
                                        EdgeInsets.all(kDefaultPadding / 2),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.white,
                                      //color: Colors.white.withOpacity(0.3),
                                      //borderRadius: BorderRadius.all(Radius.circular(10)),),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Column(
                                      children: [
                                        Expandable(
                                          // <-- Driven by ExpandableController from ExpandableNotifier
                                          collapsed: ExpandableButton(
                                            // <-- Expands when tapped on the cover photo
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '  Tarih',
                                                  style: TextStyle(
                                                      color: Colors.purple,
                                                      fontSize: 18),
                                                ),
                                                Icon(
                                                  Icons.arrow_downward_rounded,
                                                  color: Colors.purple,
                                                ),
                                              ],
                                            ),
                                          ),
                                          expanded: Column(children: [
                                            Text(
                                              'Tarih Testleri',
                                              style: TextStyle(
                                                  color: Colors.purple,
                                                  fontSize: 17),
                                              textAlign: TextAlign.center,
                                            ),
                                            Divider(
                                              color: Colors.purple,
                                              thickness: 2,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  kDefaultPadding),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: Column(
                                                children: [
                                                  CategorySample(index: 6),
                                                  CategorySample(index: 7),
                                                  SizedBox(height: 10,),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: Colors.white,
                                              child: ExpandableButton(
                                                // <-- Collapses when tapped on
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '  Tarih',
                                                      style: TextStyle(
                                                          color: Colors.purple,
                                                          fontSize: 17),
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
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    _controller.survivalActive = true;
                                    _controller.survHigh.value = 0;
                                    _controller
                                        .getTheRightSurvivalQuestions("surv_3");
                                    Get.to(SurvivalQuizScreen());
                                  },
                                  child: GetBuilder<GlowAnimationController>(
                                      init: GlowAnimationController(),
                                      builder: (controller) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              color: Colors.purple,
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: controller
                                                        .animation.value,
                                                    blurRadius: controller
                                                        .animation.value,
                                                    color: Colors.purple
                                                        .withOpacity(0.8))
                                              ]),
                                          height: 35,
                                          width: 225,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                              SizedBox(
                                height: 20,
                              ),
                              /*Container(
                                padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                                child: ExpandableNotifier(  // <-- Provides ExpandableController to its children
                                  child: Container(
                                    padding: EdgeInsets.all(kDefaultPadding/2),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.white,
                                      //color: Colors.white.withOpacity(0.3),
                                      //borderRadius: BorderRadius.all(Radius.circular(10)),),
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Column(
                                      children: [
                                        Expandable(           // <-- Driven by ExpandableController from ExpandableNotifier
                                          collapsed: ExpandableButton(  // <-- Expands when tapped on the cover photo
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('  Türkçe',style: TextStyle(color: Colors.purple,fontSize: 20),),
                                                Icon(Icons.arrow_downward_rounded,color: Colors.purple,),
                                              ],
                                            ),
                                          ),
                                          expanded: Column(
                                              children: [
                                                Text('Türkçe Testleri',style: TextStyle(color: Colors.purple,fontSize: 25),),
                                                Divider(color: Colors.purple,thickness: 2,),
                                                Container(
                                                  padding: EdgeInsets.all(kDefaultPadding),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      CategorySample(index: 6),
                                                      CategorySample(index: 7),
                                                      CategorySample(index: 8),
                                                      Container(
                                                        width: 225,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            primary: Colors.purple,
                                                          ),
                                                          onPressed: (){
                                                            _controller.survivalActive = true;
                                                            _controller.getTheRightSurvivalQuestions("surv_2");
                                                            Get.to(SurvivalQuizScreen());
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text('Hayatta Kalma Modu',style: TextStyle(color: Colors.white,fontSize: 15),),
                                                              Icon(Icons.access_time_rounded),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10,)
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child: ExpandableButton(       // <-- Collapses when tapped on
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text('  Türkçe',style: TextStyle(color: Colors.purple,fontSize: 20),),
                                                        Icon(Icons.arrow_upward_rounded,color: Colors.purple,),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ]
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),*/
                            ],
                          ),
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
  CategorySample({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      width: 155,
      height: 300,
      child: Column(
        children: [
          //sınav ismi
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Text(
              _controller.quizes[index].quizName ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, color: Colors.purple, fontFamily: 'Quicksand'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //kazanılan yıldızlar
          Container(
              width: 155,
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (_controller.quizesScores[
                                _controller.quizes[index].id! - 1] >
                            0)
                        ? Icon(
                            Icons.star,
                            color: Colors.yellow,
                          )
                        : Icon(
                            Icons.star_border,
                            color: Colors.grey,
                          ),
                    (_controller.quizesScores[
                                _controller.quizes[index].id! - 1] >
                            1)
                        ? Icon(
                            Icons.star,
                            color: Colors.yellow,
                          )
                        : Icon(
                            Icons.star_border,
                            color: Colors.grey,
                          ),
                    (_controller.quizesScores[
                                _controller.quizes[index].id! - 1] >
                            2)
                        ? Icon(
                            Icons.star,
                            color: Colors.yellow,
                          )
                        : Icon(
                            Icons.star_border,
                            color: Colors.grey,
                          ),
                  ],
                ),
              )),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              _controller.activeQuiz = _controller.quizes[index].id! - 1;
              _controller
                  .getTheRightQuestions(_controller.quizes[index].questionsId!);
              _controller.getQuizScreen();
            },
            child: Container(
              height: 140,
              width: 180,
              decoration: BoxDecoration(
                color: _controller.quizes[index].category == 1
                    ? nkColor
                    : _controller.quizes[index].category == 2
                        ? iaColor
                        : hloiColor,
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
                      _controller.quizes[index].quizName!,
                      style: TextStyle(fontSize: 20, fontFamily: 'Swissblack'),
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
