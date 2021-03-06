import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';

class BarangItem extends StatelessWidget {
  final String image;
  final String nama;
  final String subtitle;
  final String harga;
  final int stock;
  final EndIcon endIcon;
  final Function tapCallback;

  const BarangItem(
      {this.image, this.nama, this.subtitle, this.stock, @required this.endIcon, this.tapCallback, this.harga});

  Widget buildIconWidget() {
    switch (endIcon) {
      case EndIcon.Nothing:
        return Container();
      case EndIcon.Cart:
        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: tapCallback,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Icon(
                Icons.shopping_cart,
                color: Color(0xFF493C70),
              ),
            ),
          ),
        );
      case EndIcon.Clear:
        return Container(
          padding: EdgeInsets.all(15),
          child: InkWell(
            onTap: tapCallback,
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.red[600]),
              child: Icon(Icons.clear, color: Colors.white, size: 25),
            ),
          ),
        );
      case EndIcon.Confirming:
        return Chip(
          backgroundColor: Colors.yellow[900],
          padding: EdgeInsets.all(0),
          label: Text('Menunggu', style: TextStyle(color: Colors.white)),
        );
      case EndIcon.Borrowing:
        return Chip(
          backgroundColor: Colors.blueAccent,
          padding: EdgeInsets.all(0),
          label: Text('Dipinjam', style: TextStyle(color: Colors.white)),
        );
      case EndIcon.Done:
        return Chip(
          backgroundColor: Colors.green[700],
          padding: EdgeInsets.all(0),
          label: Text('Selesai', style: TextStyle(color: Colors.white)),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 10, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CachedNetworkImage(
              width: 75,
              height: 75,
              fit: BoxFit.cover,
              imageUrl: image,
            ),
          ),
          SizedBox(width: 10),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  nama,
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF403269),
                  ),
                ),
                SizedBox(height: 5),
                Text(harga == null ? 'Tempo $subtitle' : 'Rp $harga,-',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF776A9E),
                    )),
              ],
            ),
          ),
          Spacer(),
          buildIconWidget()
        ],
      ),
    );
  }
}
