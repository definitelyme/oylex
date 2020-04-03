import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/components/auth/text-form-input.dart';

class NewAccountScreen extends StatefulWidget {
  @override
  _NewAccountScreenState createState() => _NewAccountScreenState();
}

class _NewAccountScreenState extends State<NewAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailNode = FocusNode();
  bool _autoValidate = false;
  String _email;

  void _navigateBack() {
    // TODO: Navigate and Pop Screen from Stack
  }

  void _navigateToLogin() => Navigator.of(context).popAndPushNamed("/login");

  void _validateAndProceed() {
    if (!_formKey.currentState.validate()) {
      // If Form is not valid
      setState(() {
        // else set state & turn on autovalidate
        _autoValidate = true;
      });
      return;
    }
    print("First Name: $_email");
  }

  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("New Account",
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
            onPressed: _navigateBack,
            tooltip: MaterialLocalizations.of(context).backButtonTooltip),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Start by entering your email \naddress below.",
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
                      key: _formKey,
                      autovalidate: _autoValidate,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(16, 10.0, 16.0, 10.0),
                        alignment: Alignment.center,
                        child: AuthTextField(
                          textCapitalization: TextCapitalization.none,
                          hint: "Your Email Address",
                          focusNode: _emailNode,
                          inputAction: TextInputAction.go,
                          validator: (value) {
                            if (_email == null || _email.isEmpty)
                              return "Field is required";
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = RegExp(pattern);
                            if (!regex.hasMatch(_email))
                              return "Enter a valid email!";
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => _email = value,
                          onInputAction: () => _validateAndProceed,
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Already have an account?",
                textAlign: TextAlign.center,
                style: GoogleFonts.assistantTextTheme()
                    .display4
                    .copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
              ),
              RawMaterialButton(
                constraints: BoxConstraints(),
                child: Text(
                  "SIGN IN",
                  style: GoogleFonts.assistantTextTheme().body2.copyWith(
                      color: AppColors.oylexPrimary.shade600,
                      fontSize: 16.0,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.bold),
                ),
                clipBehavior: Clip.hardEdge,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                highlightColor: Colors.grey.shade200,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                onPressed: _navigateToLogin,
              ),
              SizedBox(
                height: 35.0,
              ),
              Container(
                width: (_deviceWidth / 2) * 1.83,
                height: 50.0,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        "CONTINUE",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w300),
                      ),
                      color: AppColors.oylexPrimary.shade400,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      onPressed: _validateAndProceed,
                    ),
                    Positioned(
                      right: 16.0,
                      top: 1.0,
                      bottom: 1.0,
                      child: Container(
                        padding: EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          color: AppColors.oylexPrimary.shade600,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 19.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
