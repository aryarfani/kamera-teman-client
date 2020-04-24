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
import 'package:kamera_teman_client/ui/widgets/barang_item.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Consumer3<AuthProvider, KeranjangProvider, BarangProvider>(
      builder: (context, authModel, keranjangModel, barangModel, _) {
        if (authModel.namaCurrent == null) {
          authModel.getUserData();
        }
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
                      _buildHeader(authModel, context, keranjangModel),
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
                      _buildSearch(barangModel)
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
                      child: buildListView(barangModel, keranjangModel, authModel)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container _buildSearch(BarangProvider barangModel) {
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
        onChanged: (value) {
          barangModel.findBarang(keyword: value);
        },
      ),
    );
  }

  Row _buildHeader(AuthProvider authModel, BuildContext context, KeranjangProvider keranjangModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Halo ${authModel.namaCurrent}',
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
              animationType: BadgeAnimationType.scale,
              toAnimate: true,
              badgeColor: Color(0xFF8078B6),
              badgeContent: Text(
                keranjangModel.barangKeranjang == null
                    ? 0.toString()
                    : keranjangModel.barangKeranjang.length.toString(),
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
    );
  }

  Widget buildListView(BarangProvider barangModel, KeranjangProvider keranjangModel, AuthProvider authModel) {
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
                image: linkImage + barang.gambar,
                stock: barang.stock,
                endIcon: EndIcon.Cart,
                tapCallback: () {
                  keranjangModel.addToCart(idUser: authModel.idCurrent, idBarang: barang.id);
                  showToast('Barang ditambahkan');
                },
              );
            },
          );
  }
}

// class SearchBox extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: TextField(
//         style: GoogleFonts.lato(
//           color: Colors.black87,
//           fontWeight: FontWeight.w600,
//           fontSize: 15,
//         ),
//         decoration: InputDecoration(
//           hintText: 'Cari kameramu disini',
//           prefixIcon: Icon(
//             Icons.search,
//             color: Color(0xFF403269),
//             size: 24,
//           ),
//           border: InputBorder.none,
//           hintStyle: GoogleFonts.montserrat(
//             color: Colors.black54,
//             fontWeight: FontWeight.w400,
//             fontSize: 15,
//           ),
//         ),
//         onChanged: (value) {
//           (value);
//         },
//       ),
//     );
//   }
// }
