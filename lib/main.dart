import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/helper.dart';
import 'package:oylex/Foundation/Utils/routes.dart';
import 'package:oylex/Screens/root-screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _globalKey = GlobalKey();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      //DeviceOrientation.portraitDown,
    ]);

    precacheLocalImages(context);

    return MaterialApp(
//      key: _globalKey,
      title: 'Oylex | e-Learning Platform',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: AppColors.oylexPrimary,
          buttonTheme: ButtonThemeData(minWidth: 4),
          scaffoldBackgroundColor: AppColors.windowBackground.shade700,
          accentColor: AppColors.oylexAccent,
          textTheme: GoogleFonts.workSansTextTheme(Theme.of(context).textTheme)),
//      home: SampleApp(),
//      initialRoute: IntroScreen.routeName,
      routes: router,
      onUnknownRoute: (settings) => CupertinoPageRoute(builder: (context) => RootScreen()),
    );
  }
}
