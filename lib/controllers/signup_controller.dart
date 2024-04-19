import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/auth_controller.dart';

class SignUpController extends GetxController{

  AuthController authController = Get.find();

  Rx<AutovalidateMode> autovalidateMode = AutovalidateMode.disabled.obs;


  final formKey = GlobalKey<FormState>();
  TextEditingController? SNameController,SEmailController,SPasswordController,STelController;
  String? SName = "";
  String? SEmail = "";
  String? SPassword = "";
  String? STel = "";
  DateTime? initialDate;
  RxString dText = "".obs;
  DateTime? Sdate;

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
    SNameController = TextEditingController();
    SEmailController = TextEditingController();
    SPasswordController = TextEditingController();
    STelController = TextEditingController();
    super.onInit();
  }
  onClose(){
    SNameController?.dispose();
    SEmailController?.dispose();
    SPasswordController?.dispose();
    STelController?.dispose();
  }

  String? validateEmail(String? value){
    if (value == null || value == "") {
      return "Lütfen bir e-mail adresi giriniz";
    } else if(!GetUtils.isEmail(value)){
      return "Doğru bir e-mail adresi giriniz";
    }
    return null;
  }
  String? validatePassword(String? value){
    if(value == null || value.length <= 5){
      return "Şifre en az 6 karakter olmalıdır";
    }
    return null;
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

  void checkSingUp(){
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
      Get.dialog(SpinKitHourGlass(color: Colors.purple)); // TODO https://pub.dev/packages/flutter_spinkit
      authController.createUser(
        SEmailController!.text,
        SPasswordController!.text,
        SNameController!.text,
        Sdate!,
        STelController!.text,
      );

    }
  }
  
}