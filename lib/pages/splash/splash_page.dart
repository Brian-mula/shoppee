import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodapp/routes/routes_helper.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  // !animation variables
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..forward();
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear);
    Timer(const Duration(seconds: 3),
        () => Get.offNamed(RouteHelper.getIntial()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
                child: Image.asset(
              'assets/image/logo part 1.png',
              width: 250,
            )),
          ),
          Center(
              child: Image.asset(
            'assets/image/logo part 2.png',
            width: 250,
          ))
        ],
      ),
    );
  }
}
