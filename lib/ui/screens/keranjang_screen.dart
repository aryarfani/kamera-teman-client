import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kamera_teman_client/core/models/barang.dart';
import 'package:kamera_teman_client/core/providers/auth_provider.dart';
import 'package:kamera_teman_client/core/providers/keranjang_provider.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';
import 'package:kamera_teman_client/ui/widgets/barang_item.dart';
import 'package:kamera_teman_client/ui/widgets/cool_button.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class KeranjangScreen extends StatefulWidget {
  @override
  _KeranjangScreenState createState() => _KeranjangScreenState();
}

class _KeranjangScreenState extends State<KeranjangScreen> {
  int durasiPinjam = 1;
  int jumlahBiaya;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Consumer<KeranjangProvider>(
      builder: (context, model, child) {
        var formatCurrency = NumberFormat.simpleCurrency(locale: 'IDR');
        jumlahBiaya = model.totalHarga * durasiPinjam;
        var uang = formatCurrency.format(jumlahBiaya);
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
                  height: mq.height * 0.6,
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mq.width * 0.055, vertical: 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Durasi Pinjam',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF403269),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Styles.darkPurple,
                            ),
                            child: Icon(Icons.remove, color: Colors.white),
                          ),
                          onTap: () {
                            setState(() {
                              durasiPinjam--;
                            });
                          },
                        ),
                        Text(
                          durasiPinjam.toString() + ' hari',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF403269),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Styles.darkPurple,
                            ),
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                          onTap: () {
                            setState(() {
                              durasiPinjam++;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
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
                          child: Text(
                            'Buat Pesanan',
                            style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          onPressed: () async {
                            if (model.barangKeranjang.isEmpty) {
                              showToast('Keranjang anda kosong');
                              return;
                            }
                            var cek = await model.checkOut(
                                id: Provider.of<AuthProvider>(context, listen: false).idCurrent, durasi: durasiPinjam);
                            showToast('Pemesanan Berhasil');
                            if (cek != null) {
                              setState(() {
                                durasiPinjam = 1;
                              });
                            }
                          },
                        ),
                      ],
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
                endIcon: EndIcon.Clear,
                tapCallback: () {
                  model.deleteFromCart(
                    idBarang: barang.id,
                    idUser: Provider.of<AuthProvider>(context, listen: false).idCurrent,
                    barang: barang,
                  );
                  showToast('Barang dihapus');
                },
              );
            },
          );
  }
}
