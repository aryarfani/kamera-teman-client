import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman_client/core/providers/auth_provider.dart';
import 'package:kamera_teman_client/core/providers/barang_provider.dart';
import 'package:kamera_teman_client/core/providers/keranjang_provider.dart';
import 'package:kamera_teman_client/core/providers/riwayat_provider.dart';
import 'package:kamera_teman_client/core/utils/router.dart';
import 'package:kamera_teman_client/locator.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      position: ToastPosition.bottom,
      backgroundColor: Colors.grey[600],
      textStyle: GoogleFonts.openSans(),
      textPadding: EdgeInsets.all(10.0),
      child: MultiProvider(
        providers: providers,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Kamera Teman',
          theme: ThemeData(primarySwatch: Colors.blue),
          initialRoute: RouteName.splash,
          onGenerateRoute: Router.generateRoute,
        ),
      ),
    );
  }
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<BarangProvider>(create: (context) => locator<BarangProvider>()),
  ChangeNotifierProvider<AuthProvider>(create: (context) => locator<AuthProvider>()),
  ChangeNotifierProvider<KeranjangProvider>(create: (context) => locator<KeranjangProvider>()),
  ChangeNotifierProvider<RiwayatProvider>(create: (context) => locator<RiwayatProvider>()),
];
