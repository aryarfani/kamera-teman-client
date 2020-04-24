import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman_client/core/models/barang_riwayat.dart';
import 'package:kamera_teman_client/core/providers/riwayat_provider.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';
import 'package:kamera_teman_client/ui/widgets/barang_item.dart';
import 'package:kamera_teman_client/ui/widgets/nobarang_widget.dart';
import 'package:provider/provider.dart';

class RiwayatScreen extends StatefulWidget {
  @override
  _RiwayatScreenState createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  final List<Tab> _tabTitleList = [
    Tab(child: Text('Konfirmasi')),
    Tab(child: Text('Dipinjam')),
    Tab(child: Text('Selesai')),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<RiwayatProvider>(
      builder: (context, model, child) {
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
                  width: double.infinity,
                  padding: EdgeInsets.only(top: height * 0.06, left: width * 0.04, right: width * 0.04),
                  decoration: BoxDecoration(color: Styles.darkPurple),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Riwayat',
                        style: GoogleFonts.montserrat(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Styles.coolWhite,
                        ),
                      ),
                      SizedBox(height: 10),
                      TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.white,
                        tabs: _tabTitleList,
                        controller: _tabController,
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: height,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Tab(child: UncofirmedBarang(model)),
                      Tab(child: BorrowedBarang(model)),
                      Tab(child: DoneAndCancelledBarang(model)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UncofirmedBarang extends StatelessWidget {
  UncofirmedBarang(this.model);
  final RiwayatProvider model;
  @override
  Widget build(BuildContext context) {
    if (model.unconfirmedRiwayat == null) {
      model.getUncofirmedRiwayat();
      return Center(child: CupertinoActivityIndicator());
    }
    return model.unconfirmedRiwayat.isEmpty
        ? NoBarangBg()
        : ListView.builder(
            itemCount: model.unconfirmedRiwayat.length,
            itemBuilder: (context, index) {
              BarangRiwayat barang = model.unconfirmedRiwayat[index];
              return BarangItem(
                nama: barang.nama,
                harga: '${barang.durasi * barang.harga}',
                image: linkImage + barang.gambar,
                endIcon: EndIcon.Confirming,
              );
            },
          );
  }
}

class BorrowedBarang extends StatelessWidget {
  BorrowedBarang(this.model);
  final RiwayatProvider model;
  @override
  Widget build(BuildContext context) {
    if (model.borrowedRiwayat == null) {
      model.getBorrowedMemberRiwayat();
      return Center(child: CupertinoActivityIndicator());
    }
    return model.borrowedRiwayat.isEmpty
        ? NoBarangBg()
        : ListView.builder(
            itemCount: model.borrowedRiwayat.length,
            itemBuilder: (context, index) {
              BarangRiwayat barang = model.borrowedRiwayat[index];
              return BarangItem(
                nama: barang.nama,
                subtitle: barang.tanggalTempo,
                image: linkImage + barang.gambar,
                endIcon: EndIcon.Borrowing,
              );
            },
          );
  }
}

class DoneAndCancelledBarang extends StatelessWidget {
  DoneAndCancelledBarang(this.model);
  final RiwayatProvider model;
  @override
  Widget build(BuildContext context) {
    if (model.doneAndCancelledRiwayat == null) {
      model.getDoneAndCancelledMemberRiwayat();
      return Center(child: CupertinoActivityIndicator());
    }
    return model.doneAndCancelledRiwayat.isEmpty
        ? NoBarangBg()
        : ListView.builder(
            itemCount: model.doneAndCancelledRiwayat.length,
            itemBuilder: (context, index) {
              BarangRiwayat barang = model.doneAndCancelledRiwayat[index];
              return BarangItem(
                nama: barang.nama,
                subtitle: barang.tanggalTempo,
                image: linkImage + barang.gambar,
                endIcon: EndIcon.Done,
              );
            },
          );
  }
}
