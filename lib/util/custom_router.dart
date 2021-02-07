import 'package:cricquiz11/screens/home/DashboardScreen.dart';
import 'package:cricquiz11/screens/home/home/ContestListScreen.dart';
import 'package:cricquiz11/screens/home/my_matchs/questions/QuestionnaireScreen.dart';
import 'package:cricquiz11/screens/login/LoginScreen.dart';
import 'package:cricquiz11/screens/login/otp_verification.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) {
          return LoginScreen();
        });
      case RouteNames.otpVerification:
        return MaterialPageRoute(builder: (_) {
          var data = settings.arguments as Map<String, String>;
          return OtpVerification(data);
        });
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) {
          return DashboardScreen();
        });
      case RouteNames.questionnaire:
        return MaterialPageRoute(builder: (_) {
          return QuestionnaireScreen();
        });
      case RouteNames.dashboard:
        return MaterialPageRoute(builder: (_) {
          return DashboardScreen();
        });
      case RouteNames.contest:
        return MaterialPageRoute(builder: (_) {
          var data = settings.arguments as Map<String, String>;
          return ContestListScreen(data);
        });
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}