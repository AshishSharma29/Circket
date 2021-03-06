import 'package:cricquiz11/screens/home/CricketProvider.dart';
import 'package:cricquiz11/screens/login/LoginProvider.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/constant.dart';
import 'package:cricquiz11/util/custom_router.dart';
import 'package:cricquiz11/util/route_name.dart';
import 'package:cricquiz11/util/util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var login = await Util.read(Constant.LoginResponse);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => CricketProvider())
    ],
    child: MyApp(login),
  ));
}

class MyApp extends StatelessWidget {
  var login;

  MyApp(login) {
    this.login = login;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: ColorUtils.colorPrimary,
        accentColor: ColorUtils.colorPrimaryDark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: login == null ? RouteNames.onBoarding : RouteNames.home,
      onGenerateRoute: CustomRouter.generateRoute,
    );
  }
}
