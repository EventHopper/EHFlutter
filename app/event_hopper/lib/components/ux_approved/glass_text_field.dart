import 'dart:ui';

import 'package:flutter/material.dart';

class GlassTextField extends StatefulWidget {
  final Function validator;

  GlassTextField({
    Key key,
    @required this.textFieldController,
    @required this.hintText,
    @required this.textListener,
    this.validator,
    this.focusNode,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController textFieldController;
  final ValueChanged<String> textListener;
  final String hintText;
  final FocusNode focusNode;
  bool obscureText;

  @override
  _GlassTextFieldState createState() => _GlassTextFieldState();
}

class _GlassTextFieldState extends State<GlassTextField> {
  @override
  Widget build(BuildContext context) {
    _fieldFocusChange(
        BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
      FocusScope.of(context).requestFocus(nextFocus);
    }

    return Container(
      height: 53,
      width: 267,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 9.0, sigmaY: 5.0),
          child: Stack(
            children: [
              Container(
                decoration:
                    BoxDecoration(color: Colors.white.withOpacity(0.15)),
              ),
              TextFormField(
                autofocus: false,
                onChanged: widget.textListener,
                controller: widget.textFieldController,
                decoration: buildInputDecoration(widget.hintText),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                obscureText: widget.obscureText,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, widget.focusNode, null);
                },
                validator: widget.validator,
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(String hinttext) {
    return InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: hinttext,
        hintStyle: TextStyle(color: Colors.white30),
        border: InputBorder.none,
        labelStyle: TextStyle(color: Colors.white));
  }
}
