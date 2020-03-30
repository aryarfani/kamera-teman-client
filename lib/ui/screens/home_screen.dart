import 'package:flutter/material.dart';
import 'package:kamera_teman_client/ui/screens/main_screen.dart';
import 'package:kamera_teman_client/ui/screens/riwayat_screen.dart';

class HomeScreen extends StatefulWidget {
  final int insertedIndex;
  HomeScreen({this.insertedIndex});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static int _selectedIndex = 0;

  List<Widget> screenList = [
    MainScreen(),
    RiwayatScreen(),
    Container(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Beranda'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            title: Text('Riwayat'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Akun'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF665CA9),
        onTap: onItemTapped,
      ),
      //* Untuk mencegah screen rebuild ketika diganti
      body: IndexedStack(
        index: _selectedIndex,
        children: screenList,
      ),
    );
  }
}
