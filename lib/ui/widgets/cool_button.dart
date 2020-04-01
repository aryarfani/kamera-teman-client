import 'package:flutter/material.dart';

class CoolButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  const CoolButton({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      color: Color(0xFF51427E),
      child: child,
      textColor: Colors.white,
      onPressed: onPressed,
    );
  }
}
