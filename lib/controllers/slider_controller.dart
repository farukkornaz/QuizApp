import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/date_time_controller.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';
import 'package:quiz_test_app/screens/online_quiz_screen.dart';
import 'package:quiz_test_app/screens/online_waiting_screen.dart';
import 'package:quiz_test_app/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import 'auth_controller.dart';

class SliderController extends GetxController {
  AuthController _acountController = Get.put(AuthController());
  QuestionController _questionController = Get.put(QuestionController());
  DateTimeController _dateTimeController = Get.put(DateTimeController());

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
    _questionController.onlineTestName = 'online_test';
    imageSliders = imgAList
        .map((item) => InkWell(
              onTap: () async {
                if (imgAList.indexOf(item) == 0 && dialogChecker.value == false) {
                  if (_acountController.guest) {
                    dialogChecker.value = true;
                    Get.defaultDialog(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      textConfirm: "Tamam",
                      onConfirm: () {
                        Get.back();
                      },
                      confirmTextColor: Colors.white,
                      buttonColor: Colors.purple,
                      title: "Online Sınav",
                      titleStyle: const TextStyle(fontSize: 20, color: Colors.purple),
                      content: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Column(
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
                  }
                  else if (!_acountController.guest) {
                    //TODO: isim numara al ve sınava gırmesını sagla
                    _questionController.databaseQuestions = await Database().getOnlineQData();
                    _acountController.onlineExamChecker =
                        await Database().checkOnlineExam(_acountController.user?.email ?? '', _questionController.onlineTestName);
                    if (_acountController.onlineExamChecker == 1) {
                      if (_acountController.snackWait == false) {
                        _acountController.snackbarWait();
                        Get.snackbar(
                          'Bilgilendirme',
                          "Bu Testi Çözdünüz.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.purpleAccent.withOpacity(0.5),
                          colorText: Colors.white,
                          borderColor: Colors.purpleAccent,
                          borderWidth: 1.5,
                          isDismissible: true,
                          icon: const Icon(
                            Icons.error_outline_rounded,
                            color: Colors.white,
                          ),
                          shouldIconPulse: false,
                        );
                      } else {
                        print("duplicate");
                      }
                    }
                    else if (_acountController.onlineExamChecker == 3) {
                      if (_acountController.snackWait == false) {
                        _acountController.snackbarWait();
                        Get.snackbar(
                          'Hata',
                          "Lütfen internetinizi kontrol ediniz",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.purpleAccent.withOpacity(0.5),
                          colorText: Colors.white,
                          borderColor: Colors.purpleAccent,
                          borderWidth: 1.5,
                          isDismissible: true,
                          icon: const Icon(
                            Icons.error_outline_rounded,
                            color: Colors.white,
                          ),
                          shouldIconPulse: false,
                        );
                      } else {
                        print("duplicate");
                      }
                    }
                    else {
                      calculateRemainingTime();
                      /*_ccontroller.onlineActive = true;
              _ccontroller.isVisible.value = true;
              Get.to(OnlineQuizScreen());
              _ccontroller.startTimer();*/
                    }
                  }
                }
                else if (imgAList.indexOf(item) == 1) {
                  if (!await launchUrl(_url)) throw 'Could not launch $_url';
                } else {
                  print("1");
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: imgAList.indexOf(item) != 0
                      ? Stack(
                          children: <Widget>[
                            //Image.network(item, fit: BoxFit.cover, width: 1000.0),
                            Image.asset(item, fit: BoxFit.cover, width: 1000.0),
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
                          child: const Center(
                              child: Text(
                            "ONLİNE SINAV İÇİN TIKLA !",
                            style: TextStyle(color: Colors.purple, fontSize: 18, fontWeight: FontWeight.bold),
                          )),
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
    _questionController.selectedOnlineAnswers = List<int>.filled(_questionController.databaseQuestions?.length ?? 0, -1);
    try {
      /*final result = await InternetAddress.lookup('example.com');*/
      if (/*result.isNotEmpty && result[0].rawAddress.isNotEmpty*/true) {
        await GetTime();
        await _dateTimeController.getNetworkTime();
        var dur = serverTime!.difference(_dateTimeController.myTime!);
        if (!dur.inDays.isNegative /*&& !dur.inHours.isNegative*/) {
          if (_dateTimeController.myTime!.year == serverTime!.year &&
                  _dateTimeController.myTime!.day ==
                      serverTime!.day /*&&
              (serverTime.hour - _dTController.myTime.hour == 0)*/
              ) {
            getInfoDialog();
          }
          else {
            differenceDays = (serverTime!.day - _dateTimeController.myTime!.day).toString();
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
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${differenceDays} gün kaldı",
                      style: const TextStyle(fontSize: 18),
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
              content: const Column(
                children: [
                  Text(
                    "Planlanan Sınav Bulunmamaktadır",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ).whenComplete(() => dialogChecker.value = false);
          }
        }
      }
    } on SocketException catch (_) {
      if (_acountController.snackWait == false) {
        _acountController.snackbarWait();
        Get.snackbar(
          'Uyarı',
          "İnternet Bağlantınızı Kontrol ediniz",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.purpleAccent.withOpacity(0.5),
          colorText: Colors.white,
          borderColor: Colors.purpleAccent,
          borderWidth: 1.5,
          isDismissible: true,
          icon: const Icon(
            Icons.error_outline_rounded,
            color: Colors.white,
          ),
          shouldIconPulse: false,
        );
      }
    }
  }

  String getText(int x) {
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
              const SizedBox(
                height: 1,
              ),
              Container(
                width: double.infinity,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
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
                    height: 460,
                    child: Stack(children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Soru Sayısı : ${_questionController.databaseQuestions!.length}",
                                  style: const TextStyle(
                                    color: Colors.purple,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                /*SizedBox(height: 5,),
                                           Text(
                                            "Sınav Süresi : ${_ccontroller.databaseQuestions.length*5} dakika",
                                            style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.purple),),*/
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Bilgilendirme",
                                  style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Sorular arasında geçişi ekranı kaydırarak",
                                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "veya",
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "butonları kullanarak gerçekleştiriniz",
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 75,
                                      height: 25,
                                      margin: const EdgeInsets.only(left: 7.5),
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          gradient: kPrimaryGradient,
                                          borderRadius: BorderRadius.all(Radius.circular(25))),
                                      child: const Icon(
                                        Icons.arrow_back_rounded,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 75,
                                      height: 25,
                                      margin: EdgeInsets.only(left: 7.5),
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          gradient: kPrimaryGradient,
                                          borderRadius: BorderRadius.all(Radius.circular(25))),
                                      child: const Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const AutoSizeText(
                                  "Yarışma belirtilen tarih ve saatten hemen sonra",
                                  maxLines: 1,
                                  minFontSize: 10,
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "yöneticinin sınavı başlatması ile başlayacaktır.",
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "büyüteç kullanarak büyütebilirsiniz",
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                const Icon(
                                  Icons.zoom_in_rounded,
                                  color: Colors.purple,
                                  size: 45,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text("Başarılar Dileriz"),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Get.back();
                                Get.to(OnlineWaitingScreen());
                              },
                              child: Container(
                                height: 40,
                                width: 350,
                                decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Colors.purpleAccent, width: 2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 7,
                                        blurRadius: 7,
                                        offset: const Offset(0, 0),
                                      )
                                    ]),
                                child: const Center(
                                  child: Text(
                                    "online sınav bekleme ekranına geç",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
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
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width: 65,
                                  height: 65,
                                  decoration: const BoxDecoration(
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
              const SizedBox(
                height: 1,
              ),
            ],
          ),
        ),
      ).whenComplete(() => dialogChecker.value = false);
    }
  }
}
