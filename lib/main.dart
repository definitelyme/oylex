import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/routes.dart';
import 'package:oylex/Screens/auth/verify-pin.dart';
import 'package:oylex/Screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      //DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Oylex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: AppColors.oylexPrimary,
          buttonTheme: ButtonThemeData(minWidth: 4),
          scaffoldBackgroundColor: AppColors.windowBackground,
          accentColor: AppColors.oylexAccent,
          textTheme:
              GoogleFonts.workSansTextTheme(Theme.of(context).textTheme)),
      home: VerifyPinScreen(),
      routes: router,
      onUnknownRoute: (settings) =>
          CupertinoPageRoute(builder: (context) => HomeScreen()),
    );
  }
}
