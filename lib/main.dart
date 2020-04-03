import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/routes.dart';
import 'package:oylex/Screens/auth/register-1.dart';

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
//            buttonTheme: ButtonThemeData(minWidth: 5),
          scaffoldBackgroundColor: AppColors.windowBackground,
          accentColor: AppColors.oylexAccent,
          textTheme:
              GoogleFonts.workSansTextTheme(Theme.of(context).textTheme)),
      home: NewAccountScreen(),
      routes: routes,
    );
  }
}
