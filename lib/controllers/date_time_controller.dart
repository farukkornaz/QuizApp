import 'package:get/get.dart';

class DateTimeController extends GetxController{

  DateTime? myTime;
  DateTime? ntpTime;


  Future <void> getNetworkTime() async{
    myTime = DateTime.now();
    myTime = myTime!.add(const Duration(hours: 3));

  }
}