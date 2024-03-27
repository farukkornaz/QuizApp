import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/auth_controller.dart';

import '../constants.dart';

class PassResetScreen extends GetWidget<AuthController> {
  final TextEditingController fEmailController = TextEditingController();
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Şifre Sıfırlama", style: TextStyle(fontSize: 20)),
          centerTitle: true,
        ),
        body: Container(
          color: kLightPurple,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_rounded,
                  color: Colors.purple,
                  size: 50,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Lüfen mail adresinizi düzgün yazdığınıza emin olunuz.",
                  style: TextStyle(fontSize: 21, color: Colors.purple),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email :',
                  ),
                  controller: fEmailController,
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (fEmailController.text.isEmpty) {
                      if (_authController.snackWait.value == false) {
                        _authController.snackbarWait();
                        Get.snackbar(
                          'Hata',
                          "Lütfen mail adresinizi giriniz",
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
                      controller.forgetPassword(fEmailController.text);
                    }
                  },
                  child: Text("Sıfırlama maili gönder"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
