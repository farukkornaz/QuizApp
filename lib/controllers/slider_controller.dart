import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/date_time_controller.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';
import 'package:quiz_test_app/screens/online_quiz_screen.dart';
import 'package:quiz_test_app/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import 'auth_controller.dart';

class SliderController extends GetxController {
  AuthController _acontroller = Get.put(AuthController());
  QuestionController _ccontroller = Get.put(QuestionController());
  DateTimeController _dTController = Get.put(DateTimeController());

  final List<String> imgAList = [
    'assets/images/q3.jpeg',
    'assets/images/duyuru.jpg',
  ];

  late List<Widget> imageSliders;
  RxInt current = 0.obs;
  late DateTime? serverTime;
  late String differenceDays;
  late String differenceHour;
  RxDouble BContext = 0.0.obs;
  RxBool dialogChecker = false.obs;
  final Uri _url = Uri.parse('https://www.instagram.com/farukkornaz/');

  @override
  void onInit() {
    imageSliders = imgAList
        .map((item) => InkWell(
              onTap: () async {
                if (imgAList.indexOf(item) == 0 && dialogChecker.value == false) {
                  if (_acontroller.guest) {
                    dialogChecker.value = true;
                    Get.defaultDialog(
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      textConfirm: "Tamam",
                      onConfirm: () {
                        Get.back();
                      },
                      confirmTextColor: Colors.white,
                      buttonColor: Colors.purple,
                      title: "Online Sınav",
                      titleStyle: TextStyle(fontSize: 20, color: Colors.purple),
                      content: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Sınava katılmak için hesabınıza giriş yapmanız gerekmektedir",
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            //Text("${differenceHour} saat kaldı"),
                          ],
                        ),
                      ),
                    ).whenComplete(() => dialogChecker.value = false);
                  } else if (_acontroller.user?.uid == "Ol6dYajUz2VkQT6GSoTBYnDbOQ13") {
                    await Database().getOnlineQData();
                    _ccontroller.selectedOnlineAnswers =
                        List<int>.filled(_ccontroller.databaseQuestions?.length ?? 0, -1);
                    getInfoDialog();
                  } else if (_acontroller.guest != true) {
                    await Database().getOnlineQData();
                    _acontroller.onlineExamChecker =
                        await Database().checkOnlineExam(_acontroller.user?.email ?? '', _ccontroller.onlineTestName);
                    if (_acontroller.onlineExamChecker == 1) {
                      if (_acontroller.snackWait == false) {
                        _acontroller.snackbarWait();
                        Get.snackbar(
                          'Bilgilendirme',
                          "Bu Testi Çözdünüz.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.purpleAccent.withOpacity(0.5),
                          colorText: Colors.white,
                          borderColor: Colors.purpleAccent,
                          borderWidth: 1.5,
                          isDismissible: true,
                          icon: Icon(
                            Icons.error_outline_rounded,
                            color: Colors.white,
                          ),
                          shouldIconPulse: false,
                        );
                      } else {
                        print("duplicate");
                      }
                    } else if (_acontroller.onlineExamChecker == 3) {
                      if (_acontroller.snackWait == false) {
                        _acontroller.snackbarWait();
                        Get.snackbar(
                          'Hata',
                          "Lütfen internetinizi kontrol ediniz",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.purpleAccent.withOpacity(0.5),
                          colorText: Colors.white,
                          borderColor: Colors.purpleAccent,
                          borderWidth: 1.5,
                          isDismissible: true,
                          icon: Icon(
                            Icons.error_outline_rounded,
                            color: Colors.white,
                          ),
                          shouldIconPulse: false,
                        );
                      } else {
                        print("duplicate");
                      }
                    } else {
                      calculateRemainingTime();
                      /*_ccontroller.onlineActive = true;
              _ccontroller.isVisible.value = true;
              Get.to(OnlineQuizScreen());
              _ccontroller.startTimer();*/
                    }
                  }
                } else if (imgAList.indexOf(item) == 1) {
                  if (!await launchUrl(_url)) throw 'Could not launch $_url';
                } else {
                  print("1");
                }
              },
              child: Container(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: imgAList.indexOf(item) != 0
                        ? Stack(
                            children: <Widget>[
                              //Image.network(item, fit: BoxFit.cover, width: 1000.0),
                              Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                              /*Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    top: 0.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        getText(imgAList.indexOf(item)),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),*/
                              /*Positioned(
                    top: 75,
                    left: 85,
                    right: 85,
                    child: Container(
                      width: 100,
                      height: 30,
                      child: getWidget(imgAList.indexOf(item)),
                    ),
                  ),*/
                            ],
                          )
                        : Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.purple.withOpacity(0.5),
                                Colors.purple.withOpacity(0.050),
                                Colors.purple.withOpacity(0.5),
                              ],
                            )),
                            width: double.infinity,
                            height: double.infinity,
                            child: Center(
                                child: Text(
                              "ONLİNE SINAV İÇİN TIKLA !",
                              style: TextStyle(color: Colors.purple, fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                          ),
                  ),
                ),
              ),
            ))
        .toList();
    /*if(!_acontroller.guest){
      GetTime();
    }*/
    super.onInit();
  }

  Future<void> GetTime() async {
    serverTime = await Database().getOnlineTime();
    print(serverTime);
  }

  calculateRemainingTime() async {
    _ccontroller.selectedOnlineAnswers = List<int>.filled(_ccontroller.databaseQuestions?.length ?? 0, -1);
    try {
      /*final result = await InternetAddress.lookup('example.com');*/
      if (/*result.isNotEmpty && result[0].rawAddress.isNotEmpty*/true) {
        await GetTime();
        await _dTController.getNetworkTime();
        var dur = serverTime!.difference(_dTController.myTime!);
        if (!dur.inDays.isNegative /*&& !dur.inHours.isNegative*/) {
          if (_dTController.myTime!.year == serverTime!.year &&
                  _dTController.myTime!.day ==
                      serverTime!.day /*&&
              (serverTime.hour - _dTController.myTime.hour == 0)*/
              ) {
            getInfoDialog();
          }
          /*else if (_dTController.myTime.year == serverTime.year &&
              _dTController.myTime.day == serverTime.day) {
            differenceHour = (dur.inHours + 1).floor().toString();
            Get.defaultDialog(
              title: "",
              content: Column(
                children: [
                  Text("${differenceHour} saat kaldı"),
                ],
              ),
            );
          }*/
          else {
            differenceDays = (serverTime!.day - _dTController.myTime!.day).toString();
            //differenceDays = (dur.inDays).ceil().toString();
            //differenceHour = (dur.inHours % 24).floor().toString();
            if (dialogChecker.value == false) {
              dialogChecker.value = true;
              Get.defaultDialog(
                textConfirm: "Tamam",
                onConfirm: () {
                  Get.back();
                },
                confirmTextColor: Colors.white,
                buttonColor: Colors.purple,
                title: "Online Sınav",
                titleStyle: TextStyle(fontSize: 20, color: Colors.purple),
                content: Column(
                  children: [
                    Text(
                      "Sınav günü : ${serverTime!.day}/${serverTime!.month}/${serverTime!.year}",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${differenceDays} gün kaldı",
                      style: TextStyle(fontSize: 18),
                    ),
                    //Text("${differenceHour} saat kaldı"),
                  ],
                ),
              ).whenComplete(() => dialogChecker.value = false);
              print(dur.inDays);
            }
          }
        } else {
          if (dialogChecker.value == false) {
            dialogChecker.value = true;
            Get.defaultDialog(
              textConfirm: "Tamam",
              onConfirm: () {
                Get.back();
              },
              confirmTextColor: Colors.white,
              buttonColor: Colors.purple,
              title: "Online Sınav",
              titleStyle: TextStyle(fontSize: 20, color: Colors.purple),
              content: Column(
                children: [
                  Text(
                    "Planlanan Sınav Bulunmamaktadır",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  //Text("${differenceHour} saat kaldı"),
                ],
              ),
            ).whenComplete(() => dialogChecker.value = false);
          }
        }
      }
    } on SocketException catch (_) {
      if (_acontroller.snackWait == false) {
        _acontroller.snackbarWait();
        Get.snackbar(
          'Uyarı',
          "İnternet Bağlantınızı Kontrol ediniz",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.purpleAccent.withOpacity(0.5),
          colorText: Colors.white,
          borderColor: Colors.purpleAccent,
          borderWidth: 1.5,
          isDismissible: true,
          icon: Icon(
            Icons.error_outline_rounded,
            color: Colors.white,
          ),
          shouldIconPulse: false,
        );
      }
    }
  }

  String getText(int x) {
    if (x == 2) {
      return "Siyer Testi 2021";
    }
    return 'No. $x image';
  }

  void getInfoDialog() {
    if (dialogChecker.value == false) {
      dialogChecker.value = true;
      Get.dialog(
        Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 1,
              ),
              Container(
                width: double.infinity,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 35,
                        height: 35,
                        decoration:
                            const BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(25))),
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 430,
                    child: Stack(children: [
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Soru Sayısı : ${_ccontroller.databaseQuestions!.length}",
                                  style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                /*SizedBox(height: 5,),
                                           Text(
                                            "Sınav Süresi : ${_ccontroller.databaseQuestions.length*5} dakika",
                                            style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.purple),),*/
                                SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Bilgilendirme",
                                  style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Sorular arasında geçişi ekranı kaydırarak",
                                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "veya",
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "butonları kullanarak gerçekleştiriniz",
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 75,
                                      height: 25,
                                      margin: EdgeInsets.only(left: 7.5),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          gradient: kPrimaryGradient,
                                          borderRadius: BorderRadius.all(Radius.circular(25))),
                                      child: Icon(
                                        Icons.arrow_back_rounded,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 75,
                                      height: 25,
                                      margin: EdgeInsets.only(left: 7.5),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          gradient: kPrimaryGradient,
                                          borderRadius: BorderRadius.all(Radius.circular(25))),
                                      child: Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                AutoSizeText(
                                  "Yarışma süresince yarışmaya erişebilirsiniz.",
                                  maxLines: 1,
                                  minFontSize: 10,
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Okuyamadığınız soruları",
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "büyüteç kullanarak büyütebilirsiniz",
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                Icon(
                                  Icons.zoom_in_rounded,
                                  color: Colors.purple,
                                  size: 45,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Başarılar Dileriz"),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Get.back();
                                _ccontroller.onlineActive = true;
                                _ccontroller.isVisible.value = true;
                                _ccontroller.startTimer();
                                Get.to(OnlineQuizScreen());
                              },
                              child: Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Colors.purpleAccent, width: 2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 7,
                                        blurRadius: 7,
                                        offset: const Offset(0, 0),
                                      )
                                    ]),
                                child: Center(
                                  child: Text(
                                    "Başla",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          width: BContext.value - 20,
                          top: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                  ),
                                  child: Icon(Icons.info_outline_rounded, color: Colors.purple, size: 60)),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          )),
                    ]),
                  ),
                ]),
              ),
              SizedBox(
                height: 1,
              ),
            ],
          ),
        ),
      ).whenComplete(() => dialogChecker.value = false);
    }
  }
}
