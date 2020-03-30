import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:kamera_teman_client/core/models/barang.dart';
import 'package:kamera_teman_client/core/providers/base_provider.dart';
import 'package:kamera_teman_client/core/services/keranjang_api.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';
import 'package:kamera_teman_client/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeranjangProvider extends BaseProvider {
  KeranjangApi keranjangApi = locator<KeranjangApi>();
  KeranjangProvider() {
    getJumlahBarang();
  }

  List<Barang> barangKeranjang;
  int jumlahKeranjang = 0;

  Future getJumlahBarang() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var idCurrent = storage.get('idMember');
    jumlahKeranjang = await keranjangApi.getJumlahBarangFromKeranjang(idCurrent);
    notifyListeners();
  }

  Future getAllFromKeranjang({@required int id}) async {
    setState(ViewState.Busy);
    barangKeranjang = await keranjangApi.getAllFromKeranjang(id);
    setState(ViewState.Idle);
  }

  Future addToCart({@required int idUser, @required int idBarang}) async {
    var response = await keranjangApi.addToCart(idUser, idBarang);
    if (response) {
      jumlahKeranjang++;
      notifyListeners();
    }
  }

  Future removeFromCart() async {}
}
