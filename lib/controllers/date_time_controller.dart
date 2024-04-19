import 'package:get/get.dart';

class DateTimeController extends GetxController{

  DateTime? myTime;
  DateTime? ntpTime;

  @override
  void onInit() {
    super.onInit();
  }

  Future <void> getNetworkTime() async{
    myTime = await DateTime.now();
    myTime = myTime!.add(const Duration(hours: 3));

  }
}