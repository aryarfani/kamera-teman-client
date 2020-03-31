import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman_client/core/models/barang.dart';
import 'package:kamera_teman_client/core/providers/auth_provider.dart';
import 'package:kamera_teman_client/core/providers/barang_provider.dart';
import 'package:kamera_teman_client/core/providers/keranjang_provider.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';
import 'package:kamera_teman_client/core/utils/router.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Consumer3<AuthProvider, KeranjangProvider, BarangProvider>(
      builder: (context, authmodel, keranjangModel, barangModel, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(0, 0),
            child: Visibility(
              visible: false,
              child: AppBar(),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: mq.height * 0.05,
                    left: mq.width * 0.04,
                    right: mq.width * 0.04,
                    bottom: 25,
                  ),
                  decoration: BoxDecoration(color: Styles.darkPurple),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Halo ${authmodel.namaCurrent}',
                              style: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: Styles.coolWhite,
                              )),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RouteName.keranjang);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Badge(
                                toAnimate: true,
                                badgeColor: Color(0xFF8078B6),
                                badgeContent: Text(
                                  keranjangModel.jumlahKeranjang.toString(),
                                  style: GoogleFonts.openSans(color: Colors.white),
                                ),
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Styles.coolWhite,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Yuk Pinjem Kamera ',
                        style: GoogleFonts.montserrat(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Styles.coolWhite,
                        ),
                      ),
                      SizedBox(height: 10),
                      SearchBox(),
                    ],
                  ),
                ),
                Container(
                  color: Styles.darkPurple,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      height: mq.height,
                      child: buildListView(barangModel, keranjangModel)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildListView(BarangProvider barangModel, KeranjangProvider keranjangModel) {
    return barangModel.barangs == null
        ? Center(child: CupertinoActivityIndicator())
        : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: barangModel.barangs.length,
            itemBuilder: (context, index) {
              Barang barang = barangModel.barangs[index];
              return BarangItem(
                nama: barang.nama,
                harga: barang.harga.toString(),
                image: NetworkImage(linkImage + barang.gambar),
                stock: barang.stock,
                tapCallback: () {
                  keranjangModel.addToCart(idUser: 9, idBarang: barang.id);
                },
              );
            },
          );
  }
}

class BarangItem extends StatelessWidget {
  final NetworkImage image;
  final String nama;
  final String harga;
  final int stock;
  final Function tapCallback;

  const BarangItem({this.image, this.nama, this.harga, this.stock, this.tapCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image(
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              image: image,
            ),
          ),
          SizedBox(width: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      nama,
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF403269),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: tapCallback,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Icon(
                          Icons.shopping_cart,
                          color: Color(0xFF493C70),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text('Rp. $harga /day',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF776A9E),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        style: GoogleFonts.lato(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          hintText: 'Cari kameramu disini',
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFF403269),
            size: 24,
          ),
          border: InputBorder.none,
          hintStyle: GoogleFonts.montserrat(
            color: Colors.black54,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
