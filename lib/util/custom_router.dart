import 'package:cricquiz11/screens/home/DashboardScreen.dart';
import 'package:cricquiz11/screens/home/contest/ContestTabScreen.dart';
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
          var data = settings.arguments as Map<String, String>;
          return QuestionnaireScreen(data);
        });
      case RouteNames.dashboard:
        return MaterialPageRoute(builder: (_) {
          return DashboardScreen();
        });
      case RouteNames.contest_tab:
        return MaterialPageRoute(builder: (_) {
          print(settings.arguments);
          var data = settings.arguments as Map<String, String>;
          return ContestTabScreen(data);
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
