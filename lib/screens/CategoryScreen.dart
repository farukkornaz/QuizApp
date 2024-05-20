import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quiz_test_app/controllers/category_screen_controller/category_screen_controller.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';
import 'package:quiz_test_app/models/category_model.dart';
import 'package:quiz_test_app/screens/error_screens/not_found_screen.dart';
import 'package:quiz_test_app/screens/welcome_screen.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../components/drawer_view.dart';
import '../constants.dart';
import '../models/Question.dart';
import '../models/Quiz.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  CategoryScreenController categoryScreenController =
      Get.put(CategoryScreenController());
  late final List<CategoryModel> categories;

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

  Future<List<CategoryModel>> _fetchCategories() async {
    categories = await categoryScreenController.getCategories();
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerView(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "kategori sayfası",
          style: TextStyle(fontSize: 20),
        ),
      ),
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

            return ResponsiveGridList(
              horizontalGridMargin: 50,
              verticalGridMargin: 50,
              minItemWidth: 100,
              children: List.generate(
                snapshotData.length,
                (index) => GestureDetector(
                  onTap: () {
                    if (snapshotData[index].id != null) {
                      categoryScreenController
                          .goCategoryQuizzes(snapshotData[index].id!);
                    } else {
                      Get.to(NotFound());
                    }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: kDefaultPadding),
                    child: Container(
                      padding: const EdgeInsets.all(kDefaultPadding / 2),
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
                        color: Colors.white,
                        //color: Colors.white.withOpacity(0.3),
                        //borderRadius: BorderRadius.all(Radius.circular(10)),),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Column(
                        children: [
                          Column(children: [
                            Text(
                              '${snapshotData[index].name} Testleri',
                              style: const TextStyle(
                                  color: Colors.purple, fontSize: 25),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
