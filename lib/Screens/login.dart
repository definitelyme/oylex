import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/app_icons_icons.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log In",
            style: GoogleFonts.assistantTextTheme()
                .title
                .copyWith(fontSize: 23.0, fontWeight: FontWeight.w600)),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.oylexPrimaryDark.shade200,
              size: 30.0,
            ),
            onPressed: () {},
            tooltip: MaterialLocalizations.of(context).backButtonTooltip),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Enter your login details to \naccess your account",
                textAlign: TextAlign.center,
                style: GoogleFonts.assistantTextTheme()
                    .display4
                    .copyWith(fontSize: 21.0),
              ),
              SizedBox(
                height: 70,
              ),
              Card(
                  color: Colors.transparent,
                  elevation: 0.0,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.windowBackground.shade800,
                            blurRadius: 8.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                5.0, 5.0), // shadow direction: bottom right
                          )
                        ]),
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(16, 0.0, 16.0, 0.0),
                              alignment: Alignment.center,
                              child: TextFormField(
                                maxLines: 1,
                                textCapitalization: TextCapitalization.none,
                                cursorColor: AppColors.oylexPrimary.shade400,
                                validator: (value) {},
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    isDense: true,
                                    hasFloatingPlaceholder: true,
                                    hintText: "Your Email",
                                    disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent))),
                                style: TextStyle(fontSize: 20.0),
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1.3,
                            height: 0,
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(16, 0.0, 8.0, 0.0),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      child: TextFormField(
                                        maxLines: 1,
                                        textCapitalization:
                                            TextCapitalization.none,
                                        cursorColor:
                                            AppColors.oylexPrimary.shade400,
                                        validator: (value) {},
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hasFloatingPlaceholder: true,
                                            hintText: "Your Password",
                                            disabledBorder:
                                                UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent)),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.transparent))),
                                        style: TextStyle(fontSize: 20.0),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: IconButton(
                                      icon: Icon(AppIcons.eyelash_closed),
                                      onPressed: () {},
                                    ),
                                  ),
                                  VerticalDivider(
                                    width: 0.0,
                                    indent: 12.0,
                                    endIndent: 12.0,
                                  ),
                                  Flexible(
                                    child: FlatButton(
                                      child: Text(
                                        "FORGOT",
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            letterSpacing: 1.3),
                                      ),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      padding: EdgeInsets.all(0.0),
                                      color: Colors.transparent,
                                      onPressed: () {},
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
