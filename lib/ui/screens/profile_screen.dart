import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: mq.width * 0.055, vertical: mq.height * 0.05),
        color: Styles.darkPurple,
        // decoration: BoxDecoration(color: Styles.darkPurple),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Image(
                image: AssetImage('images/4.jpg'),
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Bambang Pamungkas',
              style: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Styles.coolWhite,
              ),
            ),
            Text(
              'Mojoroto, Kediri',
              style: GoogleFonts.openSans(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Styles.coolWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
