import 'package:flutter/material.dart';
import 'package:tracker/features/Growth/growth_page.dart';
import 'package:tracker/features/Health/health_page.dart';
import 'package:tracker/features/Registration/log_in.dart';
import 'package:tracker/features/Registration/sign_up.dart';
import 'package:tracker/features/milestone/cognitive_skill/track_cognitive_skill.dart';
import 'package:tracker/features/milestone/motor_skill/track_motor_skill.dart';
import 'package:tracker/features/mainScreen/navigation_bar.dart';
import 'package:tracker/features/userData/add_baby_data.dart';
import 'package:tracker/features/userData/add_mother_data.dart';
import 'package:tracker/features/userData/add_new_baby.dart';



class Routes {
  static const String login = "login";
  static const String signUp = "sign up";
  static const String aboutMother = "userData mother";
  static const String aboutBaby = "userData baby";
  static const String home = "home";
  static const String health = "health";
  static const String growth = "growth";
  static const String addAnotherChild = "addAnotherChild";
  static const String motorSkillTracker = "motorSkillTracker";
  static const String cognitiveSkillTracker = "cognitiveSkillTracker";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const Login());
      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUp());
      case Routes.aboutMother:
        return MaterialPageRoute(builder: (_) => const MotherProfile());
      case Routes.aboutBaby:
        return MaterialPageRoute(builder: (_) => const BabyProfile());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const NavigationAppBar());
      case Routes.health:
        return MaterialPageRoute(builder: (_) => const Health());
      case Routes.growth:
        return MaterialPageRoute(builder: (_) => const Growth());
      case Routes.addAnotherChild:
        return MaterialPageRoute(builder: (_) => const AddAnotherChild());
      case Routes.motorSkillTracker:
        return MaterialPageRoute(builder: (_) =>  const MotorSkillTracker());
      case Routes.cognitiveSkillTracker:
        return MaterialPageRoute(builder: (_) =>  const CognitiveSkillTracker());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('No route found'),
              ),
              body: const Center(child: Text('No route found')),
            ));
  }
}
