import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/auth_controller.dart';

import '../constants.dart';

class PassResetScreen extends GetWidget<AuthController> {
  final TextEditingController fEmailController = TextEditingController();
  final AuthController _authController = AuthController();

  PassResetScreen({super.key});

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
          title: const Text("Şifre Sıfırlama", style: TextStyle(fontSize: 20)),
          centerTitle: true,
        ),
        body: Container(
          color: kLightPurple,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.info_rounded,
                  color: Colors.purple,
                  size: 50,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Lüfen mail adresinizi düzgün yazdığınıza emin olunuz.",
                  style: TextStyle(fontSize: 21, color: Colors.purple),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email :',
                  ),
                  controller: fEmailController,
                ),
                const SizedBox(
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
                          icon: const Icon(
                            Icons.error_outline_rounded,
                            color: Colors.white,
                          ),
                          shouldIconPulse: false,
                        );
                      } else {
                        if (kDebugMode) {
                          print("duplicate");
                        }
                      }
                    } else {
                      controller.forgetPassword(fEmailController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  child: const Text("Sıfırlama maili gönder"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
