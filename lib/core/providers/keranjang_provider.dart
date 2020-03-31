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
    getJumlahBarang();
    getAllFromKeranjang();
  }

  List<Barang> barangKeranjang;
  int _jumlahKeranjang = 0;
  int get jumlahKeranjang => _jumlahKeranjang;

  Future getJumlahBarang() async {
    print('getJumlahBarang provider');

    SharedPreferences storage = await SharedPreferences.getInstance();
    var idCurrent = storage.get('idMember');
    _jumlahKeranjang = await keranjangApi.getJumlahBarangFromKeranjang(idCurrent);
    notifyListeners();
  }

  void getAllFromKeranjang() async {
    print('getAllFromKeranjang provider');
    SharedPreferences storage = await SharedPreferences.getInstance();
    var idCurrent = storage.get('idMember');
    barangKeranjang = await keranjangApi.getAllFromKeranjang(idCurrent);
    notifyListeners();
  }

  Future addToCart({@required int idUser, @required int idBarang}) async {
    var response = await keranjangApi.addToCart(idUser, idBarang);
    if (response) {
      _jumlahKeranjang++;
      notifyListeners();
    }
  }

  Future removeFromCart() async {}
}
