import 'package:cricquiz11/screens/home/DashboardScreen.dart';
import 'package:cricquiz11/screens/home/contest/ContestTabScreen.dart';
import 'package:cricquiz11/screens/home/my_matchs/questions/QuestionnaireScreen.dart';
import 'package:cricquiz11/screens/home/profile/CoinHistory.dart';
import 'package:cricquiz11/screens/home/profile/InstructionToPlay.dart';
import 'package:cricquiz11/screens/home/profile/account_verification.dart';
import 'package:cricquiz11/screens/home/profile/settings_screen.dart';
import 'package:cricquiz11/screens/home/profile/withdraw.dart';
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
          var data = settings.arguments as Map<String, dynamic>;
          return ContestTabScreen(data);
        });
      case RouteNames.coin_history:
        return MaterialPageRoute(builder: (_) {
          print(settings.arguments);
          var data = settings.arguments as Map<String, String>;
          return CoinHistory(data);
        });
      case RouteNames.settings:
        return MaterialPageRoute(builder: (_) {
          return SettingsScreen();
        });
      case RouteNames.instruction_to_play:
        return MaterialPageRoute(builder: (_) {
          return InstructionToPlay();
        });
      case RouteNames.withdraw:
        return MaterialPageRoute(builder: (_) {
          return Withdraw();
        });
      case RouteNames.accountVerification:
        return MaterialPageRoute(builder: (_) {
          return AccountVerification();
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
