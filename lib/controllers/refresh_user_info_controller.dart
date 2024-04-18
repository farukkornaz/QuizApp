import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/auth_controller.dart';
import 'package:quiz_test_app/controllers/user_controller.dart';

class RefreshUserController extends GetxController {
  AuthController _acontroller = Get.put(AuthController());
  UserController _ucontroller = Get.put(UserController());

  @override
  void onInit() {
    GetUserInfo();
    super.onInit();
  }

  GetUserInfo() async {
    await Future.delayed(Duration(milliseconds: 1500));
    if (_acontroller.user != null && _ucontroller.user.name == null) {
      try {
        await _acontroller.refreshUserInfo();
      } catch (e) {
        _acontroller.signOut();
      }
    }
  }
}
