import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_test_app/constants.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';
import 'package:quiz_test_app/screens/quiz_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kategoriler'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.purple.shade700,
                  Colors.purple,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: ExpandableNotifier(
                      // <-- Provides ExpandableController to its children
                      child: Container(
                        padding: EdgeInsets.all(kDefaultPadding / 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          //color: Colors.white.withOpacity(0.3),
                          //borderRadius: BorderRadius.all(Radius.circular(10)),),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          children: [
                            Expandable(
                              // <-- Driven by ExpandableController from ExpandableNotifier
                              collapsed: ExpandableButton(
                                // <-- Expands when tapped on the cover photo
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '  Namaz Kitabı',
                                      style: TextStyle(
                                          color: Colors.purple, fontSize: 20),
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
                                  'Namaz Kitabı Testleri',
                                  style: TextStyle(
                                      color: Colors.purple, fontSize: 25),
                                ),
                                Divider(
                                  color: Colors.purple,
                                  thickness: 2,
                                ),
                                Container(
                                  padding: EdgeInsets.all(kDefaultPadding),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Column(
                                    children: [
                                      CategorySample(index: 0),
                                      CategorySample(index: 1),
                                      CategorySample(index: 2)
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  child: ExpandableButton(
                                    // <-- Collapses when tapped on
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '  Namaz Kitabı',
                                          style: TextStyle(
                                              color: Colors.purple,
                                              fontSize: 20),
                                        ),
                                        Icon(
                                          Icons.arrow_upward_rounded,
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
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: ExpandableNotifier(
                      // <-- Provides ExpandableController to its children
                      child: Container(
                        padding: EdgeInsets.all(kDefaultPadding / 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          //color: Colors.white.withOpacity(0.3),
                          //borderRadius: BorderRadius.all(Radius.circular(10)),),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          children: [
                            Expandable(
                              // <-- Driven by ExpandableController from ExpandableNotifier
                              collapsed: ExpandableButton(
                                // <-- Expands when tapped on the cover photo
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '  Eshab-ı Kiram',
                                      style: TextStyle(
                                          color: Colors.purple, fontSize: 20),
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
                                  'Eshab-ı Kiram Testleri',
                                  style: TextStyle(
                                      color: Colors.purple, fontSize: 25),
                                ),
                                Divider(
                                  color: Colors.purple,
                                  thickness: 2,
                                ),
                                Container(
                                  padding: EdgeInsets.all(kDefaultPadding),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Column(
                                    children: [
                                      CategorySample(index: 3),
                                      CategorySample(index: 4),
                                      CategorySample(index: 5)
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  child: ExpandableButton(
                                    // <-- Collapses when tapped on
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '  Eshab-ı Kiram',
                                          style: TextStyle(
                                              color: Colors.purple,
                                              fontSize: 20),
                                        ),
                                        Icon(
                                          Icons.arrow_upward_rounded,
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
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: ExpandableNotifier(
                      // <-- Provides ExpandableController to its children
                      child: Container(
                        padding: EdgeInsets.all(kDefaultPadding / 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          //color: Colors.white.withOpacity(0.3),
                          //borderRadius: BorderRadius.all(Radius.circular(10)),),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          children: [
                            Expandable(
                              // <-- Driven by ExpandableController from ExpandableNotifier
                              collapsed: ExpandableButton(
                                // <-- Expands when tapped on the cover photo
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '  İslam Ahlakı',
                                      style: TextStyle(
                                          color: Colors.purple, fontSize: 20),
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
                                  'İslam Ahlakı Testleri',
                                  style: TextStyle(
                                      color: Colors.purple, fontSize: 25),
                                ),
                                Divider(
                                  color: Colors.purple,
                                  thickness: 2,
                                ),
                                Container(
                                  padding: EdgeInsets.all(kDefaultPadding),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Column(
                                    children: [
                                      CategorySample(index: 6),
                                      CategorySample(index: 7),
                                      CategorySample(index: 8)
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  child: ExpandableButton(
                                    // <-- Collapses when tapped on
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '  İslam Ahlakı',
                                          style: TextStyle(
                                              color: Colors.purple,
                                              fontSize: 20),
                                        ),
                                        Icon(
                                          Icons.arrow_upward_rounded,
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
          ),
        )));
  }
}

class CategorySample extends StatelessWidget {
  const CategorySample({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 155,
          height: 200,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  _controller.quizes[index].quizName!,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.purple,
                      fontFamily:
                          GoogleFonts.quicksand(fontWeight: FontWeight.w900)
                              .fontFamily),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  print('1');
                },
                child: Container(
                  height: 140,
                  width: 180,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //Text('Category *')
            ],
          ),
        ),
        Container(
          height: 125,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Zorluk Seviyesi'),
              Row(
                children: [
                  Icon(
                    Icons.star_border,
                    color: Colors.grey,
                  ),
                  Icon(
                    Icons.star_border,
                    color: Colors.grey,
                  ),
                  Icon(
                    Icons.star_border,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                  onTap: () {
                    _controller.getTheRightQuestions(
                        _controller.quizes[index].questionsId!);
                    Get.to(QuizScreen());
                  },
                  child: Icon(
                    Icons.play_circle_fill_rounded,
                    color: Colors.purple,
                    size: 75,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
