import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';

class AuthTextField extends StatefulWidget {
  AuthTextField(
      {@required this.hint,
      this.text = "",
      this.focusNode,
      this.textCapitalization = TextCapitalization.none,
      this.keyboardType = TextInputType.text,
      this.inputAction = TextInputAction.done,
      this.obscureText = false,
      this.enableSuggestions = true,
      this.textStyle = const TextStyle(fontSize: 20.0),
      this.focusBorderSide = const BorderSide(color: Colors.transparent),
      this.enabledBorderSide = const BorderSide(color: Colors.transparent),
      @required this.validator,
      @required this.onChanged,
      this.onInputAction});

  final String hint;
  final String text;
  final FocusNode focusNode;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final BorderSide focusBorderSide, enabledBorderSide;
  final bool obscureText;
  final bool enableSuggestions;
  final TextStyle textStyle;
  final Function validator;
  final Function onChanged;
  final Function onInputAction;

  @override
  _AuthTextFieldState createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      initialValue: widget.text,
      textCapitalization: widget.textCapitalization,
      cursorColor: AppColors.oylexPrimary.shade400,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
          isDense: true,
          hasFloatingPlaceholder: true,
          hintText: widget.hint,
          disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: UnderlineInputBorder(borderSide: widget.enabledBorderSide),
          focusedBorder: UnderlineInputBorder(
            borderSide: widget.focusBorderSide,
          )),
      style: widget.textStyle,
      textInputAction: widget.inputAction,
      enableSuggestions: widget.enableSuggestions,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: (value) {
        if (widget.inputAction == TextInputAction.next) {
          widget.focusNode.unfocus();
          FocusScope.of(context).requestFocus(widget.onInputAction());
          return null;
        }
        widget.focusNode.unfocus();
        return widget.onInputAction();
      },
    );
  }
}
