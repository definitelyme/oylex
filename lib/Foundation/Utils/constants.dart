import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Pattern emailPattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
const Pattern upperCasePattern = "(.*[A-Z].*)";

const Pattern numberPattern = "[0-9]+";

const Pattern symbolPattern = "(.*[@!#\$^*()\[\]\\{}%^&+=\"\"\'\'|;:<>-_,.?\/].*)";

const IMAGES_FOLDER = "assets/images";
const INTRO_IMAGES_FOLDER = "$IMAGES_FOLDER/intro";
const PERMISSION_IMAGES_FOLDER = "$IMAGES_FOLDER/permisssions";
const MISC_IMAGES_FOLDER = "$IMAGES_FOLDER/misc";

double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

EdgeInsetsGeometry defaultEdgeSpacing(BuildContext context, {double left, double top, double right, double bottom}) =>
    EdgeInsets.fromLTRB(left ?? deviceLeftMargin(context), top ?? 0.0, right ?? deviceLeftMargin(context), bottom ?? 0.0);

double deviceMargin(BuildContext context) => deviceWidth(context) * 0.04;

double deviceLeftMargin(BuildContext context) => deviceMargin(context);

double deviceRightMargin(BuildContext context) => deviceMargin(context);

TextTheme deviceFontTheme() => GoogleFonts.workSansTextTheme();

ScrollPhysics defaultScrollPhysics() => BouncingScrollPhysics();

ScrollPhysics defaultHorizontalScrollPhysics() => BouncingScrollPhysics();
