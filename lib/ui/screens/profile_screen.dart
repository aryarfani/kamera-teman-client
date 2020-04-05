import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman_client/core/providers/auth_provider.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen(this.navbarCallback);
  final Function navbarCallback;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.darkPurple,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Akun Saya',
          style: GoogleFonts.montserrat(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.055, vertical: mq.height * 0.02),
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
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ProfileItem(
                    navbarCallback: navbarCallback,
                    title: 'Menunggu Konfirmasi',
                    trailingText: '2 Barang',
                    icon: Icons.shopping_cart,
                  ),
                  ProfileItem(
                    navbarCallback: navbarCallback,
                    title: 'Sedang Dipinjam',
                    trailingText: '4 Barang',
                    icon: Icons.shopping_cart,
                  ),
                  ProfileItem(
                    navbarCallback: navbarCallback,
                    title: 'Semua Barang',
                    trailingText: '6 Barang',
                    icon: Icons.shopping_cart,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'PENGATURAN APLIKASI',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black54),
                    ),
                  ),
                  ProfileItem(
                    navbarCallback: navbarCallback,
                    title: 'Pengaturan',
                  ),
                  ProfileItem(
                    navbarCallback: navbarCallback,
                    title: 'Versi App',
                    trailingText: '1.0.1',
                    traillingIcon: false,
                  ),
                  ProfileItem(
                    navbarCallback: () {
                      Provider.of<AuthProvider>(context, listen: false).logout(context);
                    },
                    moveToRiwayatScreen: false,
                    title: 'Keluar',
                    traillingIcon: false,
                  ),
                  SizedBox(height: 10)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  const ProfileItem(
      {this.navbarCallback,
      @required this.title,
      this.trailingText,
      this.icon,
      this.traillingIcon = true,
      this.moveToRiwayatScreen = true});

  final Function navbarCallback;
  final String title;
  final String trailingText;
  final bool traillingIcon;
  final bool moveToRiwayatScreen;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          child: ListTile(
            leading: icon != null ? Icon(icon) : null,
            title: Text(title, style: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w500)),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              trailingText != null
                  ? Text(trailingText, style: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w500))
                  : Container(),
              traillingIcon == true ? Icon(Icons.navigate_next) : Container(),
            ]),
          ),
          onTap: () {
            moveToRiwayatScreen == true ? navbarCallback(1) : navbarCallback();
          },
        ),
        Divider(color: Colors.black54, height: 5)
      ],
    );
  }
}
