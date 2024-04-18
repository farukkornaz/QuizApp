import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/auth_controller.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';

import '../constants.dart';
import '../screens/profile_screen.dart';
import '../screens/user_statistics.dart';

class DrawerView extends GetWidget<AuthController> {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());

    return Container(
      width: 225,
      child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Container(
          color: kLightPurple,
          child: Column(
            // Important: Remove any padding from the ListView.
            //padding: EdgeInsets.zero,
            children: [
              Container(
                height: 125,
                child: DrawerHeader(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                  ),
                  child: Container(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Quick Quiz',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (controller.user != null) {
                    Get.back();
                    Get.to(ProfileScreen());
                  }
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.purple, width: 2)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle_rounded,
                        color: Colors.purple,
                        size: 30,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Obx(() {
                        return AutoSizeText(
                          '${(Get.find<AuthController>().user != null) ? Get.find<AuthController>().user!.email!.split("@")[0] : 'Misafir'}',
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.purple, width: 2)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          "Toplanan Yıldızlar",
                          style: TextStyle(color: Colors.purple),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 35,
                              ),
                              Container(
                                  width: 75,
                                  child: Text(
                                    "${_controller.quizesScoresSum} / ${_controller.quizes.length * 3}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )),
                              SizedBox(
                                width: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Text("Hayatta Kalma Modu",
                            style: TextStyle(color: Colors.purple)),
                        Text("Toplam Skor",
                            style: TextStyle(color: Colors.purple)),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.watch_later_rounded,
                                color: Colors.purple,
                                size: 35,
                              ),
                              Container(
                                  width: 75,
                                  child: Text(
                                    "${_controller.survivalScoresSum} Puan",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )),
                              SizedBox(
                                width: 1,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                indent: 4,
                endIndent: 4,
                color: Colors.purple,
                thickness: 2,
              ),
              ListTile(
                leading: Icon(Icons.bar_chart_rounded),
                title: Text('İstatistikler'),
                onTap: () {
                  //Get.back();
                  Get.to(UserStatistics());
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Ayarlar'),
                onTap: () {},
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(child: Container()),
              //Expanded(child: Container()),
              InkWell(
                onTap: () {
                  if (controller.guest) {
                    Get.back();
                    Get.back();
                    controller.guest = false;
                  } else
                    Get.find<AuthController>().signOut();
                },
                child: Container(
                  height: 50,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.purple, width: 2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.power_settings_new_rounded,
                        color: Colors.blueAccent,
                      ),
                      (controller.guest)
                          ? Text('Giriş Yap')
                          : Text('Hesaptan Çıkış'),
                      SizedBox(
                        width: 1,
                      )
                    ],
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
