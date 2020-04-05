import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';

class ToolBar extends AppBar {
  ToolBar(
      {Key key,
      @required BuildContext context,
      String title,
      IconData leading = Icons.arrow_back,
      isCentered = true,
      @required Function leadingAction,
      trailingWidgets = const <Widget>[]})
      : super(
          key: key,
          title: Text(title,
              style: GoogleFonts.assistantTextTheme().title.copyWith(
                  fontSize: 23.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.18)),
          elevation: 0.0,
          centerTitle: isCentered,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(
                leading,
                color: AppColors.oylexPrimaryDark.shade200,
                size: 30.0,
              ),
              onPressed: leadingAction,
              tooltip: MaterialLocalizations.of(context).backButtonTooltip),
          actions: trailingWidgets,
        );
}
