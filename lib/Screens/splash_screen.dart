import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_demo/Routes/route.dart' as rt;
import 'package:resume_demo/Utils/constants.dart';
import 'package:resume_demo/Utils/custom_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 3), () => Get.offAllNamed(rt.Route.homeScreen));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: CustomWidget.text("Welcome to resume builder app",
            fontWeight: FontWeight.bold, color: AppColor.primaryColor,fontSize: 20),
      ),
    ));
  }
}
