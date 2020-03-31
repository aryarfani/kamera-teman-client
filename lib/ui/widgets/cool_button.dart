import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoolButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const CoolButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.all(13.0),
      color: Color(0xFF51427E),
      child: Text(
        text,
        style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      textColor: Colors.white,
      onPressed: onPressed,
    );
  }
}
