import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Foundation/Utils/routes.dart';
import 'package:oylex/Foundation/Utils/validator.dart';
import 'package:oylex/Models/RouteArgs/auth-props.dart';
import 'package:oylex/Screens/auth/login.dart';
import 'package:oylex/Screens/auth/register-2.dart';
import 'package:oylex/components/appbar.dart';
import 'package:oylex/components/auth/text-form-input.dart';

class NewAccountScreen extends StatefulWidget {
  static const routeName = "/register";

  @override
  _NewAccountScreenState createState() => _NewAccountScreenState();
}

class _NewAccountScreenState extends State<NewAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameNode = FocusNode();
  final _lastNameNode = FocusNode();
  final _emailNode = FocusNode();
  TapGestureRecognizer _gotoLoginRecognizer;
  bool _autoValidate = false;
  String _firstName, _lastName, _email;

  void _validateAndProceed() {
    if (!_formKey.currentState.validate()) {
      // If Form is not valid
      setState(() {
        // else set state & turn on auto-validate
        _autoValidate = true;
      });
      return;
    }
    // TODO: Validate email not in firestore first
    AuthArgs newUserDetails = AuthArgs(firstName: _firstName, lastName: _lastName, email: _email);
    // Proceed ro Create Password Page
    Navigator.of(context).pushNamed(CreatePasswordScreen.routeName, arguments: newUserDetails);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Already have an account...Sign in
    _gotoLoginRecognizer = TapGestureRecognizer()
      ..onTap = () => navigatePopAndPush(
            context: context,
            routeName: LoginScreen.routeName,
            arguments: AuthArgs(email: _email),
          );

    // Get the email from AuthArgs (if available)
    final AuthArgs args = ModalRoute.of(context).settings.arguments;
    _email = args.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolBar(
        context: context,
        title: "New Account",
        leadingAction: () => navigateAndReplace(context: context, routeName: LoginScreen.routeName),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: ListView(
          physics: defaultScrollPhysics(),
          scrollDirection: Axis.vertical,
          controller: ScrollController(),
          padding: defaultEdgeSpacing(context, top: deviceHeight(context) * .03),
          children: <Widget>[
            Text(
              "Start by entering your details below. \nAll fields are required!.",
              textAlign: TextAlign.center,
              style: defaultTextTheme().display4.copyWith(fontSize: 18.0),
            ),
            SizedBox(
              height: deviceHeight(context) * .08,
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
                      offset: Offset(5.0, 5.0), // shadow direction: bottom right
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(16, 5.0, 16.0, 5.0),
                        alignment: Alignment.center,
                        child: AuthTextField(
                          textCapitalization: TextCapitalization.words,
                          hint: "First Name",
                          text: _firstName,
                          focusNode: _firstNameNode,
                          inputAction: TextInputAction.next,
                          validator: (value) => Validator.emptyFieldValidator(value),
                          onChanged: (value) => _firstName = value,
                          onInputAction: () => _lastNameNode,
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 0,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(16, 5.0, 16.0, 5.0),
                        alignment: Alignment.center,
                        child: AuthTextField(
                          textCapitalization: TextCapitalization.words,
                          hint: "Last Name",
                          text: _lastName,
                          focusNode: _lastNameNode,
                          inputAction: TextInputAction.next,
                          validator: (value) => Validator.emptyFieldValidator(value),
                          onChanged: (value) => _lastName = value,
                          onInputAction: () => _emailNode,
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 0,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(16, 5.0, 16.0, 5.0),
                        alignment: Alignment.center,
                        child: AuthTextField(
                          textCapitalization: TextCapitalization.none,
                          hint: "E-mail Address",
                          focusNode: _emailNode,
                          text: _email,
                          inputAction: TextInputAction.send,
                          validator: (value) => Validator.emailValidator(value),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => _email = value,
                          onInputAction: _validateAndProceed,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight(context) * .05,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  recognizer: _gotoLoginRecognizer,
                  style: defaultTextTheme().display4.copyWith(fontSize: 17.0, fontWeight: FontWeight.w400),
                  text: "Already have an account?",
                  children: [
                    TextSpan(
                      recognizer: _gotoLoginRecognizer,
                      text: "\nSIGN IN",
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
              height: deviceHeight(context) * .05,
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
                      style: TextStyle(color: Colors.white, fontSize: 18.0, letterSpacing: 1.2, fontWeight: FontWeight.w300),
                    ),
                    color: AppColors.oylexPrimary.shade400,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(14.0)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.oylexPrimary.shade50,
                    blurRadius: 8.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ],
              ),
            ),
            SizedBox(
              height: deviceHeight(context) * .10,
            ),
          ],
        ),
      ),
    );
  }
}
