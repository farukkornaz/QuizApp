import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/user_controller.dart';
import 'package:quiz_test_app/controllers/user_update_controller.dart';

import '../constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserUpdateController userUpdateController = Get.put(UserUpdateController());
    UserController userController = Get.find<UserController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Kullanıcı Bilgileri"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: SingleChildScrollView(
            child: Obx(
              () => Form(
                key: userUpdateController.formKey,
                autovalidateMode: userUpdateController.autovalidateMode.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userController.user.email ?? '',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLength: 30,
                      decoration: InputDecoration(
                        labelText:
                            'Adınız : ${userController.user.name ?? ""/* != "" ? _uController.user.name : ""*/}',
                        counterText: "",
                      ),
                      controller: userUpdateController.SNameController,
                      onSaved: (value) {
                        userUpdateController.SName = value ?? '';
                      },
                      validator: (value) {
                        return userUpdateController.validateName(value ?? '');
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
                      maxLength: 11,
                      decoration: InputDecoration(
                        labelText:
                            'Tel : ${userController.user.tel != "" ? userController.user.tel : ""}',
                        counterText: "",
                      ),
                      controller: userUpdateController.STelController,
                      onSaved: (value) {
                        userUpdateController.STel = value!;
                      },
                      validator: (value) {
                        return userUpdateController.validateTel(value ?? '');
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(
                          kDefaultPadding, 5, kDefaultPadding, 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purple,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "Doğum Tarihiniz : ${userController.user.birthday != "" ? userUpdateController.birthday : ""} ${userUpdateController.dText.value}"),
                          IconButton(
                            onPressed: () {
                              userUpdateController.pickDate(context);
                              userUpdateController.birthday = "";
                            },
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
                    TextButton(
                        onPressed: () {
                          userUpdateController.checkUpdate();
                        },
                        child: const Text(
                          'Güncelle',
                          style: TextStyle(color: Colors.purple),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
