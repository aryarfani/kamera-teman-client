import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:kamera_teman_client/core/models/barang.dart';
import 'package:kamera_teman_client/core/providers/base_provider.dart';
import 'package:kamera_teman_client/core/services/keranjang_api.dart';
import 'package:kamera_teman_client/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeranjangProvider extends BaseProvider {
  KeranjangApi keranjangApi = locator<KeranjangApi>();
  KeranjangProvider() {
    init();
  }

  init() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    int idCurrent = storage.get('idMember');

    getJumlahBarang(idUser: idCurrent);
    getBarangsFromKeranjang(idUser: idCurrent);
    getTotalHarga(idUser: idCurrent);
    print('keranjangProvider created');
  }

  List<Barang> barangKeranjang;
  int _jumlahKeranjang = 0;
  int get jumlahKeranjang => _jumlahKeranjang;
  int _totalHarga = 0;
  int get totalHarga => _totalHarga;

  Future getJumlahBarang({@required int idUser}) async {
    print('getJumlahBarang provider');

    _jumlahKeranjang = await keranjangApi.getJumlahBarangFromKeranjang(idUser);
    notifyListeners();
  }

  Future getTotalHarga({@required int idUser}) async {
    print('getTotalHarga');

    _totalHarga = await keranjangApi.getTotalHarga(idUser);
    notifyListeners();
  }

  void getBarangsFromKeranjang({@required int idUser}) async {
    print('getBarangsFromKeranjang provider');

    barangKeranjang = await keranjangApi.getBarangsFromKeranjang(idUser);
    notifyListeners();
  }

  Future addToCart({@required int idUser, @required int idBarang}) async {
    print('addToCart is working');

    var response = await keranjangApi.addToCart(idUser, idBarang);
    if (response) {
      // _jumlahKeranjang++;
      init();
    }
    print('addToCart is done');
  }

  Future deleteFromCart({@required int idUser, @required int idBarang}) async {
    print('deleteFromCart is working');

    var response = await keranjangApi.deleteFromCart(idUser, idBarang);
    if (response) {
      // _jumlahKeranjang--;
      // barangKeranjang.remove(barang);
      // notifyListeners();
      init();
    }
    print('deleteFromCart is done');
  }
}
