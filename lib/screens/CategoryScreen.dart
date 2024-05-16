import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';
import 'package:quiz_test_app/screens/welcome_screen.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../constants.dart';
import '../models/Question.dart';
import '../models/Quiz.dart';

class Category extends StatelessWidget {
  Category({super.key});

  QuestionController questionController = Get.put(QuestionController());

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("kategori sayfası"),
      ),
      body: ResponsiveGridList(
        horizontalGridMargin: 50,
        verticalGridMargin: 50,
        minItemWidth: 100,
        children: List.generate(
          100,
          (index) => GestureDetector(
            onTap: (){
              //Todo: veritabanından gelen veriler gösterilecek
              print(index);
            },
            child: ColoredBox(
              color: Colors.lightBlue,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  '$index',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("kategori sayfası"),
      ),
      body: ResponsiveGridList(
        horizontalGridMargin: 50,
        verticalGridMargin: 50,
        minItemWidth: 100,
        children: List.generate(
          100,
              (index) => GestureDetector(
            onTap: (){
              //Todo: veritabanından gelen veriler gösterilecek
              print(index);
            },
            child: Container(
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
            ),
          ),
        ),
    );
  }
}



