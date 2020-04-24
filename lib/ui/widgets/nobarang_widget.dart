import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';

class NoBarangBg extends StatelessWidget {
  const NoBarangBg({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'belum ada item :(',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Styles.darkPurple,
          ),
        ),
        SvgPicture.asset('images/bg_empty.svg', width: 200),
      ],
    ));
  }
}
