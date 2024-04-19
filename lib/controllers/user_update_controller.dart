import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/auth_controller.dart';
import 'package:quiz_test_app/controllers/user_controller.dart';
import 'package:quiz_test_app/services/database.dart';

class UserUpdateController extends GetxController{

  Rx<AutovalidateMode> autovalidateMode = AutovalidateMode.disabled.obs;
  AuthController _Acontroller = Get.put(AuthController());
  UserController _Ucontroller = Get.find<UserController>();


  final formKey = GlobalKey<FormState>();
  late TextEditingController SNameController,STelController;
  var SName = "";
  var STel = "";
  var initialDate;
  RxString dText = "".obs;
  DateTime? Sdate;
  String? birthday;

  Future pickDate(BuildContext context) async{
    if(initialDate == null){
      initialDate = DateTime.now();}
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year-100),
      lastDate: DateTime(DateTime.now().year+1),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.white,
              onPrimary: Colors.purple.shade700,
              surface: Colors.purple.shade700,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor:Colors.purple[700],
          ),
          child: child ?? SizedBox(),
        );
      },
    );
    if(newDate != null){
      Sdate = newDate;
      getText();
    }

  }

  void getText(){
    if(Sdate == null){
      dText.value = "";
    }else{
      dText.value = "${Sdate!.day}/${Sdate!.month}/${Sdate!.year}";
      initialDate = Sdate;
    }
  }

  @override
  void onInit() {
    birthday = _Ucontroller.user.birthday;
    SNameController = TextEditingController();
    STelController = TextEditingController();
    super.onInit();
  }
  onClose(){
    SNameController.dispose();
    STelController.dispose();
  }


  String? validateTel(String? value){
    if(value == null || value == ""){
      return null;
    }
    else if(value.length != 11){
      return "Lütfen doğru bir telefon numarası giriniz";
    }
    return null;
  }
  String? validateName(String? value){
    if(value == null || value == ""){
      return null;
    }
    else if(value.length<2){
      return "Lütfen adınızı giriniz";
    }
    return null;
  }

  void checkUpdate() async{
    autovalidateMode.value = AutovalidateMode.onUserInteraction;
    final isValid = formKey.currentState?.validate() ?? false;
    if(!isValid){
      return;
    }/*else if(Sdate == null){
      Get.defaultDialog(title: "",content: Column(
        children: [
          Icon(Icons.info_outline_rounded,size: 50,color: Colors.purple,),
          SizedBox(height: 20,),
          Text("Lütfen Doğum Tarihinizi Seçiniz",style: TextStyle(color: Colors.purple),),
          SizedBox(height: 20,)
        ],
      ));
    }*/else{
      formKey.currentState?.save();
      //Get.defaultDialog(title: "",content: Text("Üye oluşturuldu"),);
      Get.dialog(SpinKitHourGlass(color: Colors.purple));
      try{
        await Database().setUserInfo(
            _Acontroller.user!.uid,
            _Acontroller.user!.email!,
            SNameController.text,
            STelController.text,
            dText.value);
        Get.back();
        Get.back();
        _Ucontroller.user = await Database().getUser(_Acontroller.user!.uid);
        Get.snackbar("İşlem Başarılı", "Bilgileriniz Güncellenmiştir.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.purpleAccent.withOpacity(0.5),
          colorText: Colors.white,
          borderColor: Colors.purpleAccent,
          borderWidth: 1.5,
          isDismissible: true,
          shouldIconPulse: false,
        );
      }catch(e){
        Get.back();
        Get.back();
        Get.snackbar('Error', e.toString(),
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

}