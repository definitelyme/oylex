import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Foundation/Utils/routes.dart';
import 'package:oylex/Foundation/Utils/validator.dart';
import 'package:oylex/Models/RouteArgs/auth-props.dart';
import 'package:oylex/Models/country.dart';
import 'package:oylex/Screens/auth/verify-pin.dart';
import 'package:oylex/components/appbar.dart';
import 'package:oylex/components/auth/text-form-input.dart';

class PhoneNumberScreen extends StatefulWidget {
  static final routeName = "/phone-number";

  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberNode = FocusNode();
  List<DropdownMenuItem<Country>> _dropdownItems;
  bool _autoValidate = false;
  bool _isSkipBtnHighlighted = false;
  String _phoneNumber;
  List<Country> _countries = Country.getCountryCodes();
  Country _selectedCountry;

  void _skipTwoStepVerification() {
    //
  }

  void _onCountryChange(Country value) {
    setState(() {
      _selectedCountry = value; // Handle Country/Language Change
    });
  }

  void _validateAndProceed() {
    AuthArgs newUserDetails = AuthArgs(phone: _phoneNumber);
    // Proceed ro Create Password Page
    Navigator.of(context).pushNamed(VerifyPinScreen.routeName, arguments: newUserDetails);
  }

  @override
  void initState() {
    _dropdownItems = _buildCountriesMenu(_countries);
    _selectedCountry = _countries.firstWhere((country) => country.codeName == "US"); // Set the current country as US - English. Please replace with server values
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolBar(
        context: context,
        title: "Let's Get Started",
        leadingAction: () => navigateBack(context),
        trailingWidgets: <Widget>[
          FlatButton(
            onPressed: _skipTwoStepVerification,
            color: Colors.white10,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            child: Text(
              "SKIP",
              style: defaultTextTheme().display4.copyWith(fontSize: 17.0, color: _isSkipBtnHighlighted ? Colors.black : Colors.grey.shade400, fontWeight: FontWeight.w500),
            ),
            onHighlightChanged: (value) => setState(() => _isSkipBtnHighlighted = value),
          )
        ],
      ),
      body: SingleChildScrollView(
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
                  height: deviceHeight(context) * .05,
                ),
                Text(
                  "Enter your mobile number to \nenable 2-step verification.",
                  textAlign: TextAlign.center,
                  style: defaultTextTheme().display4.copyWith(fontSize: 18.0),
                ),
                SizedBox(
                  height: deviceHeight(context) * .10,
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 0,
                            child: Container(
                              margin: EdgeInsets.only(left: 16.0),
                              child: DropdownButton(
                                value: _selectedCountry,
                                items: _dropdownItems,
                                hint: Text(
                                  "+00",
                                  style: defaultTextTheme().display4.copyWith(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w300,
                                      ),
                                ),
                                icon: null,
                                iconSize: 0.0,
                                isDense: true,
                                elevation: 0,
                                underline: SizedBox(),
                                onChanged: _onCountryChange,
                              ),
                            ),
                          ),
                          Container(
                            height: 24.0,
                            width: 0.67,
                            color: Colors.grey.shade400,
                            margin: const EdgeInsets.only(left: 4.0, right: 4.0),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 5.0, 16.0, 0.0),
                              child: AuthTextField(
                                textCapitalization: TextCapitalization.none,
                                hint: "Mobile Number",
                                focusNode: _phoneNumberNode,
                                inputAction: TextInputAction.go,
                                enableSuggestions: false,
                                keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                                validator: (String value) => Validator.passwordValidator(value),
                                onChanged: (value) => _phoneNumber = value,
                                onInputAction: () => _validateAndProceed,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceHeight(context) * .16,
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
          )),
    );
  }

  List<DropdownMenuItem<Country>> _buildCountriesMenu(List<Country> countries) {
    List<DropdownMenuItem<Country>> items = List();
    countries.forEach((country) => {
          items.add(DropdownMenuItem(
              value: country,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 0,
                    child: Flags.getMiniFlag(country.codeName, 16.0, null),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        "${country.dialCode}",
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                ],
              )))
        });

    return items;
  }
}
