import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/app_icons_icons.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Foundation/Utils/routes.dart';
import 'package:oylex/Models/RouteArgs/auth-props.dart';
import 'package:oylex/Screens/auth/register-1.dart';
import 'package:oylex/components/appbar.dart';
import 'package:oylex/components/auth/text-form-input.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();
  TapGestureRecognizer _gotoSignupRecognizer;
  bool _passwordObscured = true;
  bool _autoValidate = false;
  String _email, _password;

  void _toggleObscurity() => setState(() => _passwordObscured = !_passwordObscured);

  void _navigateBack() => navigateBack(context);

  void _forgotPassword() {
    // TODO: Navigate to Forgot Password Screen
  }

  void _validateAndLogin() {
    if (!_formKey.currentState.validate()) {
      // If Form is not valid
      setState(() {
        // else set state & turn on auto-validate
        _autoValidate = true;
      });
      return;
    }
    print("Email: $_email");
    print("Password: $_password");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Don't have an account...Sign up
    _gotoSignupRecognizer = TapGestureRecognizer()
      ..onTap = () => navigateAndReplace(
            context: context,
            routeName: NewAccountScreen.routeName,
            arguments: AuthArgs(email: _email),
          );

    // Get the email from AuthArgs (if available)
    final AuthArgs args = ModalRoute.of(context).settings.arguments;
    if (args != null) _email = args.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolBar(
        context: context,
        title: "Login",
        leadingAction: _navigateBack,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: ListView(
          physics: defaultScrollPhysics(),
          scrollDirection: Axis.vertical,
          controller: ScrollController(),
          padding: defaultEdgeSpacing(context, top: deviceHeight(context) * .03),
          shrinkWrap: true,
          children: <Widget>[
            Text(
              "Enter your login details to \naccess your account",
              textAlign: TextAlign.center,
              style: defaultTextTheme().display4.copyWith(fontSize: 18.0),
            ),
            SizedBox(
              height: deviceHeight(context) * .08, // 70,
            ),
            Card(
                color: Colors.transparent,
                elevation: 0.0,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.0)), boxShadow: [
                    BoxShadow(
                      color: AppColors.windowBackground.shade800,
                      blurRadius: 8.0,
                      spreadRadius: 0.0,
                      offset: Offset(5.0, 5.0), // shadow direction: bottom right
                    )
                  ]),
                  child: Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(16, 5.0, 16.0, 5.0),
                          alignment: Alignment.center,
                          child: AuthTextField(
                            textCapitalization: TextCapitalization.none,
                            hint: "Your Email",
                            focusNode: _emailNode,
                            inputAction: TextInputAction.next,
                            text: _email,
                            validator: (value) {
                              if (_email == null || _email.isEmpty) return "Field is required";
                              if (!RegExp(emailPattern).hasMatch(_email)) return "Enter a valid email!";
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) => _email = value,
                            onInputAction: () => _passwordNode,
                          ),
                        ),
                        Divider(
                          thickness: 1.3,
                          height: 0,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(16, 5.0, 16.0, 5.0),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: Container(
                                  child: AuthTextField(
                                    textCapitalization: TextCapitalization.none,
                                    focusNode: _passwordNode,
                                    inputAction: TextInputAction.go,
                                    validator: (value) {
                                      if (_password == null || _password.isEmpty) return "Field is required";
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
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
                                  icon: Icon(_passwordObscured ? AppIcons.eyelash_closed : AppIcons.eyelash_open),
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
                                    style: TextStyle(color: Colors.grey.shade600, letterSpacing: 1.3),
                                  ),
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  padding: EdgeInsets.all(8.0),
                                  color: Colors.transparent,
                                  onPressed: _forgotPassword,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: deviceHeight(context) * .05, // 35.0
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  recognizer: _gotoSignupRecognizer,
                  style: defaultTextTheme().display4.copyWith(fontSize: 17.0, fontWeight: FontWeight.w400),
                  text: "Hey! You're new",
                  children: [
                    TextSpan(
                      recognizer: _gotoSignupRecognizer,
                      text: "\nSIGN UP",
                      style: defaultTextTheme().body2.copyWith(
                            color: AppColors.oylexPrimary.shade600,
                            fontSize: 15.8,
                            letterSpacing: 1.15,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight(context) * .05, // 25.0,
            ),
            Container(
              width: deviceWidth(context) * 0.83,
              height: 50.0,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      "CONTINUE",
                      style: TextStyle(color: Colors.white, fontSize: 16.5, letterSpacing: 1.2, fontWeight: FontWeight.w300),
                    ),
                    color: AppColors.oylexPrimary.shade400,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
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
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(14.0)), boxShadow: [
                BoxShadow(
                  color: AppColors.oylexPrimary.shade50,
                  blurRadius: 8.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ]),
            ),
            SizedBox(
              height: deviceHeight(context) * .10,
            )
          ],
        ),
      ),
    );
  }
}
