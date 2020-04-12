import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/routes.dart';
import 'package:oylex/Models/RouteArgs/permission-args.dart';
import 'package:oylex/Screens/intro-screen.dart';
import 'package:oylex/Screens/root-screen.dart';
import 'package:oylex/components/appbar.dart';
import 'package:oylex/components/permission.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
//import 'package:h';

class VerifyPinScreen extends StatefulWidget {
  static final routeName = "/code-verification";

  @override
  _VerifyPinScreenState createState() => _VerifyPinScreenState();
}

class _VerifyPinScreenState extends State<VerifyPinScreen> {
  static final _pinLength = 4;
  TapGestureRecognizer _onTapRecognizer;
  bool _autoValidate = false;
  String _errorText = "";
  bool _pinFieldEnabled = true;
  String _pinCode;

  void _validatePinCode() {
    if (_pinCode == null) {
      setState(() {
        _errorText = "* Verification code is required";
        _autoValidate = true;
      });
    } else if (_pinCode.length < _pinLength) {
      setState(() {
        _errorText = "* Incorrect input. Try again";
        _autoValidate = true;
      });
    }
//    else if (_pinCode != "5644") {
//      setState(() {
//        _errorText = "* Invalid Verification Code";
//        _autoValidate = true;
//      });
//    }
    else {
      setState(() {
        _autoValidate = false;

        PermissionArgs args = PermissionArgs(
            image: "9.png",
            title: "Notifications",
            description:
                "Stay notified about new course updates from instructors, score board stats and friend follows",
            nextRoute: RootScreen.routeName,
            skipEnabled: true);

        navigateAndPopUntil(
            context: context,
            routeName: PermissionComponent.routeName,
            popUntilRouteName: IntroScreen.routeName,
            arguments: args);
      });
    }
  }

  @override
  void initState() {
    _onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        print("Resend Verification!");
      };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    double _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: ToolBar(
        context: context,
        title: "Verification",
        leadingAction: () => navigateBack(context),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          controller: ScrollController(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: _deviceHeight * .05,
                ),
                Text(
                  "We e-mailed you a code to verify \nyour phone number",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.assistantTextTheme()
                      .display4
                      .copyWith(fontSize: 21.0),
                ),
//                Image.asset(
//                  "assets/images/verify.png",
//                  height: MediaQuery.of(context).size.height / 2.5,
//                  fit: BoxFit.fitHeight,
//                ),
                SizedBox(
                  height: _deviceHeight * .10,
                ),
                PinCodeTextField(
                  length: _pinLength,
                  fieldHeight: 56,
                  fieldWidth: 56,
                  borderWidth: 1.0,
                  obsecureText: false,
                  enableActiveFill: true,
                  enabled: _pinFieldEnabled,
                  backgroundColor: Colors.transparent,
                  animationType: AnimationType.none,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12.0),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  activeColor: Colors.white,
                  // Border-color when active
                  inactiveColor: AppColors.oylexPrimary,
                  // Border-color when inactive
                  activeFillColor: Colors.white,
                  // Fill-color when active
                  inactiveFillColor: Colors.transparent,
                  // Fill-color when inactive
                  selectedColor: AppColors.oylexPrimaryDark.shade600,
                  // Border-color when selected
                  selectedFillColor: Colors.transparent,
                  // Fill-color when selected
                  textInputType: TextInputType.number,
                  onCompleted: (String value) {
                    print("Pin Code: $value");
                  },
                  onChanged: (value) => _pinCode = value,
                ),
                Visibility(
                  visible: _autoValidate,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        _errorText,
                        style: GoogleFonts.assistantTextTheme()
                            .display4
                            .copyWith(
                                color: Colors.red.shade300,
                                fontSize: 15,
                                letterSpacing: 1.1),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _deviceHeight * .07,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "I did not receive a code",
                      recognizer: _onTapRecognizer,
                      style: GoogleFonts.assistantTextTheme()
                          .display4
                          .copyWith(color: Colors.black54, fontSize: 16),
                      children: [
                        TextSpan(
                            text: "\nRESEND",
                            recognizer: _onTapRecognizer,
                            style: GoogleFonts.assistantTextTheme()
                                .display4
                                .copyWith(
                                    color: AppColors.oylexPrimary.shade600,
                                    fontSize: 15.8,
                                    letterSpacing: 1.1,
                                    fontWeight: FontWeight.bold))
                      ]),
                ),
                SizedBox(
                  height: _deviceHeight * .06,
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
                            borderRadius: BorderRadius.circular(14.0)),
                        onPressed: _validatePinCode,
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
                          offset: Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ]),
                ),
                SizedBox(
                  height: _deviceHeight * .10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
