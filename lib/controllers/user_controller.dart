import 'package:get/get.dart';
import 'package:quiz_test_app/models/user.dart';

class UserController extends GetxController{
  Rx<UserModel> _userModel = UserModel().obs; // usermodel type obs variable

  UserModel get user => _userModel.value; // get the value and update when its change

  set user(UserModel value) => this._userModel.value = value; // set new value

  void clear(){// reset user values
    _userModel.value = UserModel();
  }
}