import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/app_icons_icons.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Foundation/Utils/routes.dart';
import 'package:oylex/Foundation/Utils/validator.dart';
import 'package:oylex/Models/RouteArgs/auth-props.dart';
import 'package:oylex/Screens/auth/login.dart';
import 'package:oylex/Screens/auth/phone-number.dart';
import 'package:oylex/Screens/intro-screen.dart';
import 'package:oylex/components/appbar.dart';
import 'package:oylex/components/auth/text-form-input.dart';

class CreatePasswordScreen extends StatefulWidget {
  static const routeName = "/register-password";

  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordNode = FocusNode();
  TapGestureRecognizer _gotoLoginRecognizer;
  bool _passwordObscured = true;
  bool _autoValidate = false;
  String _firstName, _lastName, _email, _password;

  void _toggleObscurity() {
    setState(() {
      _passwordObscured = !_passwordObscured;
    });
  }

  void _validateAndProceed() {
    if (!_formKey.currentState.validate()) {
      // If Form is not valid
      setState(() {
        // else set state & turn on auto-validate
        _autoValidate = true;
      });
      return;
    }

    // Create User's Account based on the ffing
    print("First Name: $_firstName");
    print("Last Name: $_lastName");
    print("Email: $_email");
    print("New Password: $_password");

    navigateAndPopUntil(context: context, routeName: PhoneNumberScreen.routeName, popUntilRouteName: IntroScreen.routeName);
  }

  @override
  void initState() {
    // Already have an account...Sign in
    _gotoLoginRecognizer = TapGestureRecognizer()
      ..onTap = () => navigatePopAndPush(
            context: context,
            routeName: LoginScreen.routeName,
            arguments: AuthArgs(email: _email),
          );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve User's info from previous route
    final AuthArgs args = ModalRoute.of(context).settings.arguments;
    _firstName = args.firstName;
    _lastName = args.lastName;
    _email = args.email;

    return Scaffold(
      appBar: ToolBar(
        context: context,
        title: "Create Password",
        leadingAction: () => navigateBack(context),
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
              "Your password must be at least \n8 or more characters and contain \nan uppercase character and a number.",
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
                      )
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(16, 5.0, 16.0, 5.0),
                            alignment: Alignment.center,
                            child: AuthTextField(
                              textCapitalization: TextCapitalization.none,
                              hint: "New Password",
                              focusNode: _passwordNode,
                              inputAction: TextInputAction.go,
                              enableSuggestions: false,
                              keyboardType: TextInputType.text,
                              obscureText: _passwordObscured,
                              validator: (String value) => Validator.passwordValidator(value),
                              onChanged: (value) => _password = value,
                              onInputAction: _validateAndProceed,
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
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: deviceHeight(context) * .07,
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
              height: deviceHeight(context) * .06,
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
                      style: defaultTextTheme().body1.copyWith(
                            color: Colors.white,
                            fontSize: 17.0,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w300,
                          ),
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
