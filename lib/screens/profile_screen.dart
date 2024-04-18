import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/user_controller.dart';
import 'package:quiz_test_app/controllers/user_update_controller.dart';

import '../constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserUpdateController controller = Get.put(UserUpdateController());
    UserController _uController = Get.find<UserController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Kullanıcı Bilgileri"),
      ),
      body: Center(
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
                    Container(
                      child: Text(
                        _uController.user.email ?? '',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLength: 30,
                      decoration: InputDecoration(
                        labelText:
                            'Adınız : ${_uController.user.name ?? ""/* != "" ? _uController.user.name : ""*/}',
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
                    SizedBox(
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
                            'Tel : ${_uController.user.tel != "" ? _uController.user.tel : ""}',
                        counterText: "",
                      ),
                      controller: controller.STelController,
                      onSaved: (value) {
                        controller.STel = value!;
                      },
                      validator: (value) {
                        return controller.validateTel(value ?? '');
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
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
                              "Doğum Tarihiniz : ${_uController.user.birthday != "" ? controller.birthday : ""} ${controller.dText.value}"),
                          IconButton(
                            onPressed: () {
                              controller.pickDate(context);
                              controller.birthday = "";
                            },
                            icon: Icon(
                              Icons.calendar_today_rounded,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          controller.checkUpdate();
                        },
                        child: Text(
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
