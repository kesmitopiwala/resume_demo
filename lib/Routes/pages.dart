import 'package:get/get.dart' show GetPage, Transition;
import 'package:resume_demo/Routes/route.dart';
import 'package:resume_demo/Screens/home_screen.dart';
import 'package:resume_demo/Screens/resume_edit_screen.dart';
import 'package:resume_demo/Screens/splash_screen.dart';

const Transition transition = Transition.cupertino;

class AppPages {
  // ignore: constant_identifier_names
  static const INITIAL = Route.splashScreen;

  static final routes = [
    GetPage(
        name: Route.splashScreen,
        page: () => const SplashScreen(),
        transition: transition),
    GetPage(
        name: Route.homeScreen,
        page: () => const HomeScreen(),
        transition: transition),
    GetPage(
        name: Route.resumeEditScreen,
        page: () => const ResumeEditScreen(null),
        transition: transition),
  ];
}