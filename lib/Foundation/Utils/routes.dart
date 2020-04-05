import 'package:flutter/cupertino.dart';
import 'package:oylex/Models/RouteArgs/route-args.dart';
import 'package:oylex/Screens/auth/login.dart';
import 'package:oylex/Screens/auth/phone-number.dart';
import 'package:oylex/Screens/auth/register-1.dart';
import 'package:oylex/Screens/auth/register-2.dart';
import 'package:oylex/Screens/auth/verify-pin.dart';
import 'package:oylex/Screens/home.dart';
import 'package:oylex/Screens/intro-screen.dart';
import 'package:oylex/components/permission.dart';

var router = {
  IntroScreen.routeName: (context) => IntroScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  NewAccountScreen.routeName: (context) => NewAccountScreen(),
  CreatePasswordScreen.routeName: (context) => CreatePasswordScreen(),
  VerifyPinScreen.routeName: (context) => VerifyPinScreen(),
  PhoneNumberScreen.routeName: (context) => PhoneNumberScreen(),
  PermissionComponent.routeName: (context) => PermissionComponent(),
};

void navigateAndReplace(
        {BuildContext context,
        String routeName,
        RouteArgs arguments,
        dynamic result}) =>
    Navigator.pushReplacementNamed(context, routeName,
        arguments: arguments, result: result);

void navigateAndPush(
        {BuildContext context, String routeName, RouteArgs arguments}) =>
    Navigator.pushNamed(context, routeName, arguments: arguments);

void navigatePopAndPush(
        {BuildContext context, String routeName, RouteArgs arguments}) =>
    Navigator.popAndPushNamed(context, routeName, arguments: arguments);

void navigateAndPopUntil(
        {BuildContext context,
        String routeName,
        String popUntilRouteName,
        RouteArgs arguments}) =>
    Navigator.pushNamedAndRemoveUntil(
        context, routeName, ModalRoute.withName(popUntilRouteName),
        arguments: arguments);

void navigateBack(BuildContext context) => Navigator.pop(context);
