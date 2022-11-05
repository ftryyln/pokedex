import 'dart:async';

import 'package:get/get.dart';
import 'package:pokedex/ui/home/home_screen.dart';

class SplashController extends GetxController{


  @override
  void onInit() {
    Timer(const Duration(seconds: 3), () => Get.offAll(() => const HomeScreen()));
    super.onInit();
  }
}