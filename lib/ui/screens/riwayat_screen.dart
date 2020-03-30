import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    Tab(child: Text('Semua')),
    Tab(child: Text('Pinjaman')),
    Tab(child: Text('Selesai')),
  ];

  final List<Tab> _tabChildrenList = [
    Tab(child: SemuaBarang()),
    Tab(child: Text('Pinjaman')),
    Tab(child: Text('Selesai')),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
              decoration: BoxDecoration(color: Color(0xFF665CA9)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Riwayat',
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      // color: Color(0xFF403269),
                      color: Color(0xFFEBEDF4),
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
                children: _tabChildrenList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SemuaBarang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        BarangItem(
          image: AssetImage('images/canon.png'),
          name: 'Canon 600D',
          harga: '40.000',
          stock: 2,
        ),
        BarangItem(
          image: AssetImage('images/flash_nikon.png'),
          name: 'Flash Nikon',
          harga: '5.000',
          stock: 4,
        ),
        BarangItem(
          image: AssetImage('images/sony.png'),
          name: 'Digital Camera Sony',
          harga: '25.000',
          stock: 8,
        ),
        BarangItem(
          image: AssetImage('images/tripod_nikon.png'),
          name: 'Tripod Nikon',
          harga: '27.000',
          stock: 1,
        ),
        BarangItem(
          image: AssetImage('images/flash_nikon.png'),
          name: 'Flash Nikon',
          harga: '5.000',
          stock: 4,
        ),
        BarangItem(
          image: AssetImage('images/sony.png'),
          name: 'Digital Camera Sony',
          harga: '25.000',
          stock: 8,
        ),
        BarangItem(
          image: AssetImage('images/tripod_nikon.png'),
          name: 'Tripod Nikon',
          harga: '27.000',
          stock: 1,
        ),
      ],
    );
  }
}

class BarangItem extends StatelessWidget {
  final AssetImage image;
  final String name;
  final String harga;
  final int stock;

  const BarangItem({this.image, this.name, this.harga, this.stock});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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
                      name,
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF403269),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Icon(Icons.favorite_border, color: Colors.grey),
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
