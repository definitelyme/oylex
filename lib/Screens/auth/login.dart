import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/app_icons_icons.dart';
import 'package:oylex/components/auth/text-form-input.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();
  bool _passwordObscured = true;
  bool _autoValidate = false;
  String _email, _password;

  void _toggleObscurity() {
    setState(() {
      _passwordObscured = !_passwordObscured;
    });
  }

  void _navigateBack() {
    // TODO: Navigate and Pop Screen from Stack
  }

  void _forgotPassword() {
    // TODO: Navigate to Forgot Password Screen
  }

  void _validateAndLogin() {
    if (!_formKey.currentState.validate()) {
      // If Form is not valid
      setState(() {
        // else set state & turn on autovalidate
        _autoValidate = true;
      });
      return;
    }
    print("First Name: $_email");
    print("Last Name: $_password");
  }

  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;

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
                height: 40.0,
              ),
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
                      key: _formKey,
                      autovalidate: _autoValidate,
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
                              child: AuthTextField(
                                textCapitalization: TextCapitalization.none,
                                hint: "Your Email",
                                focusNode: _emailNode,
                                inputAction: TextInputAction.next,
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
                                onInputAction: () => _passwordNode,
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
                                      child: AuthTextField(
                                        textCapitalization:
                                            TextCapitalization.none,
                                        focusNode: _passwordNode,
                                        inputAction: TextInputAction.go,
                                        validator: (value) {
                                          if (_password == null ||
                                              _password.isEmpty)
                                            return "Field is required";
                                          return null;
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        obscureText: _passwordObscured,
                                        hint: "Your Password",
                                        onChanged: (value) => _password = value,
                                        onInputAction: _validateAndLogin,
                                      ),
                                    ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    shape: CircleBorder(),
                                    clipBehavior: Clip.hardEdge,
                                    child: IconButton(
                                      icon: Icon(_passwordObscured
                                          ? AppIcons.eyelash_closed
                                          : AppIcons.eyelash_open),
                                      onPressed: _toggleObscurity,
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
                                      onPressed: _forgotPassword,
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
                height: 60.0,
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
                      onPressed: _validateAndLogin,
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
