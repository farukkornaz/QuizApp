import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';
import 'package:quiz_test_app/controllers/user_controller.dart';
import 'package:quiz_test_app/models/user.dart';
import 'package:quiz_test_app/services/database.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>(); //firebase user

  User? get user => _firebaseUser.value;
  bool guest = false;
  RxBool showHide = true.obs;
  RxBool snackWait = false.obs;
  var onlineExamChecker;

  @override
  onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  refreshUserInfo() async {
    Get.find<UserController>().user = await Database().getUser(Get.find<AuthController>().user?.uid ?? "");
  }

  void createUser(String email, String password, String name, DateTime birthday, String tel) async {
    try {
      //final result = await InternetAddress.lookup('example.com');
      if (/*result.isNotEmpty && result[0].rawAddress.isNotEmpty*/true) {
        try {
          UserCredential _userCredential =
              await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
          UserModel _user = UserModel(
            id: _userCredential.user?.uid,
            email: email,
            name: name,
            tel: tel,
            birthday: "${birthday.day}/${birthday.month}/${birthday.year}",
          );
          bool _check = (await Database().createNewUser(_user));
          if (_check) {
            Get.find<UserController>().user = _user;
            Get.back();
            Get.back();
            print('created');
          }
          /*if(await Database().createNewUser(_user)){
        //user created successfuly
        Get.find<UserController>().user = _user;
        Get.back();
        print('created');
      } */
        } catch (e) {
          Get.back();
          if (snackWait.value == false) {
            snackbarWait();
            Get.snackbar(
              'Hata',
              e.toString(),
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
      }
    } on SocketException catch (_) {
      Get.back();
      if (snackWait.value == false) {
        snackbarWait();
        Get.snackbar(
          'Hata',
          "İnternetinizi kontrol ediniz",
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
  }

  void login(String email, String password) async {
    if (email == "" || password == "") {
      if (snackWait.value == false) {
        snackbarWait();
        Get.snackbar(
          'Hata',
          "Lütfen bilgilerinizi eksiksiz giriniz",
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
    } else {
      try {
        // Todo: internet kontrolü için farklı bir metod kullan
        // final result = await InternetAddress.lookup('example.com');
        if (/*result.isNotEmpty && result[0].rawAddress.isNotEmpty*/true) {
          try {
            UserCredential _userCredential =
                await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
            Get.find<UserController>().user =
                await Database().getUser(_userCredential.user?.uid ?? '');
            print('login successful');
            guest = false;
            Get.find<QuestionController>().getQuizesScores();
          } catch (e) {
            String hatamsj;
            switch (e.toString()) {
              case "ERROR_INVALID_EMAIL":
                hatamsj = "Email adresinizi kontrol ediniz";
                break;
              case "ERROR_WRONG_PASSWORD":
                hatamsj = "Şifreniz yanlış";
                break;
              case "ERROR_USER_NOT_FOUND":
                hatamsj = "Kullanıcı bulunamadı";
                break;
              default:
                hatamsj = "Lütfen bilgilerinizin doğruluğunu kontrol ediniz";
            }

            if (snackWait.value == false) {
              snackbarWait();
              Get.snackbar(
                'Hata',
                hatamsj,
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
        }
      } on SocketException catch (_) {
        if (snackWait.value == false) {
          snackbarWait();
          Get.snackbar(
            'Hata',
            "İnternetinizi kontrol ediniz",
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
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().clear(); // reset all values in controller
      print('Signed Out');
    } catch (e) {
      if (snackWait.value == false) {
        snackbarWait();
        Get.snackbar(
          'Hata',
          e.toString(),
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
  }

  void forgetPassword(String email) {
    try {
      _auth.sendPasswordResetEmail(email: email);
      Get.back();
      if (snackWait.value == false) {
        snackbarWait();
        Get.snackbar(
          "Sıfırlama Maili Gönderildi",
          "Lütfen Mail Adresinizi Kontrol Ediniz",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.purpleAccent.withOpacity(0.5),
          colorText: Colors.white,
          borderColor: Colors.purpleAccent,
          borderWidth: 1.5,
          isDismissible: true,
          shouldIconPulse: false,
        );
      } else {
        print("duplicate");
      }
    } catch (e) {
      if (snackWait.value == false) {
        snackbarWait();
        Get.snackbar(
          'Hata',
          e.toString(),
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
  }

  void showOrHide() {
    showHide.value = !showHide.value;
  }

  snackbarWait() async {
    snackWait.value = true;
    await Future.delayed(const Duration(seconds: 3));
    snackWait.value = false;
  }
}
