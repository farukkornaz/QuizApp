
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/get.dart';

class CooldownControl extends GetxController{

  CountDownController ccontroller = CountDownController();

  void pause(){
    ccontroller.pause();
  }

  void resume(){
    ccontroller.start();
  }
  void restart(){
    ccontroller.restart(duration: 30);
  }

}