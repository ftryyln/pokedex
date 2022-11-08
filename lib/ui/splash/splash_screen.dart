import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex/ui/splash/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) => Scaffold(
          backgroundColor: Color(0xfff00000),
              body: Center(
                child: Lottie.asset("assets/pokeball_lottie.json", height: 100),
              ),
            ));
  }
}
