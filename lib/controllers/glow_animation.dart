import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlowAnimationController extends GetxController with GetSingleTickerProviderStateMixin{

  late AnimationController _animationController; // _variable means private type

  late Animation _animation;

  Animation get animation => this._animation;

  @override
  void onInit() {
    _animationController =
        AnimationController(duration: const Duration(milliseconds: 700), vsync: this);
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 1.0, end: 3.0).animate(_animationController)
      ..addListener(() {
        //update like setState
        update();
      });
    super.onInit();
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }

}