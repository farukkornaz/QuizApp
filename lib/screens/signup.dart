import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/constants.dart';
import 'package:quiz_test_app/controllers/signup_controller.dart';

class Signup extends GetWidget<SignUpController> {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController controller = Get.put(SignUpController());

    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kayıt Ol', style: TextStyle(fontSize: 20)),
          centerTitle: true,
        ),
        body: Container(
          color: kLightPurple,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: SingleChildScrollView(
                child: Obx(
                  () => Form(
                    key: controller.formKey,
                    autovalidateMode: controller.autovalidateMode.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "* Zorunlu Alanlar",
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          maxLength: 30,
                          decoration: const InputDecoration(
                            hintText: 'Ad Soyad',
                            labelText: 'Adınız :',
                            counterText: "",
                          ),
                          controller: controller.SNameController,
                          onSaved: (value) {
                            controller.SName = value ?? '';
                          },
                          validator: (value) {
                            return controller.validateName(value ?? '');
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        /*TextFormField(
                            onTap: () => controller.pickDate(context),
                            decoration: InputDecoration(
                                labelText: controller.dText.value,
                            ),
                            controller: controller.SAgeController,
                            onSaved: (value){
                              controller.SAge = value;
                            },
                            validator: (value){
                              return controller.validateAge(value);
                            },
                          ),*/
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          maxLength: 30,
                          decoration: const InputDecoration(
                            hintText: 'örnek@örnekmail.com',
                            labelText: '*Email :',
                            counterText: "",
                          ),
                          controller: controller.SEmailController,
                          onSaved: (value) {
                            controller.SEmail = value;
                          },
                          validator: (value) {
                            return controller.validateEmail(value);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          maxLength: 20,
                          decoration: const InputDecoration(
                            hintText: 'en az 6 karakter',
                            labelText: '*Şifre :',
                            counterText: "",
                          ),
                          controller: controller.SPasswordController,
                          onSaved: (value) {
                            controller.SPassword = value;
                          },
                          validator: (value) {
                            return controller.validatePassword(value);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          maxLength: 11,
                          decoration: const InputDecoration(
                            hintText: '05*********',
                            labelText: 'Tel :',
                            counterText: "",
                          ),
                          controller: controller.STelController,
                          onSaved: (value) {
                            controller.STel = value;
                          },
                          validator: (value) {
                            return controller.validateTel(value);
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(kDefaultPadding, 5, kDefaultPadding, 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.purple,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Doğum Tarihiniz :    ${controller.dText.value}"),
                              IconButton(
                                onPressed: () => controller.pickDate(context),
                                icon: const Icon(
                                  Icons.calendar_today_rounded,
                                  color: Colors.purple,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.checkSingUp();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              minimumSize: Size.infinite,
                            ),
                            child: const Text('Kayıt Ol'),
                          ),
                        ),
                      ],
                    ),
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
