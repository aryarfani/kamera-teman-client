import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kamera_teman_client/core/models/barang.dart';
import 'package:kamera_teman_client/core/providers/auth_provider.dart';
import 'package:kamera_teman_client/core/providers/keranjang_provider.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';
import 'package:kamera_teman_client/ui/widgets/cool_button.dart';
import 'package:provider/provider.dart';

class KeranjangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Consumer<KeranjangProvider>(
      builder: (context, model, child) {
        var formatCurrency = NumberFormat.simpleCurrency(locale: 'IDR');
        var uang = formatCurrency.format(model.totalHarga);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Styles.darkPurple,
            elevation: 0,
          ),
          body: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: mq.width * 0.055),
                decoration: BoxDecoration(color: Styles.darkPurple),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Keranjang',
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Styles.coolWhite,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.search, color: Colors.white70)
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Container(
                color: Styles.darkPurple,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                  child: buildListView(context, model),
                  height: mq.height * 0.7,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mq.width * 0.055, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '$uang,-',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF403269),
                      ),
                    ),
                    CoolButton(
                      text: 'Pesan',
                      onPressed: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildListView(context, KeranjangProvider model) {
    return model.barangKeranjang == null
        ? Center(child: CupertinoActivityIndicator())
        : ListView.builder(
            itemCount: model.barangKeranjang.length,
            itemBuilder: (context, index) {
              Barang barang = model.barangKeranjang[index];
              return BarangItem(
                nama: barang.nama,
                harga: barang.harga.toString(),
                image: NetworkImage(linkImage + barang.gambar),
                stock: barang.stock,
                tapCallback: () {
                  model.deleteFromCart(
                    idBarang: barang.id,
                    idUser: Provider.of<AuthProvider>(context, listen: false).idCurrent,
                  );
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
      padding: EdgeInsets.only(left: 20, top: 10, right: 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image(
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              image: image,
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
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF403269),
                  ),
                ),
                SizedBox(height: 5),
                Text('Rp. $harga /day',
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF776A9E),
                    )),
              ],
            ),
          ),
          Spacer(),
          InkWell(
            onTap: tapCallback,
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.red[600],
              ),
              child: Icon(
                Icons.clear,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
