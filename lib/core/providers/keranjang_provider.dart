import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:kamera_teman_client/core/models/barang.dart';
import 'package:kamera_teman_client/core/providers/base_provider.dart';
import 'package:kamera_teman_client/core/services/keranjang_api.dart';
import 'package:kamera_teman_client/core/services/riwayat_api.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';

class KeranjangProvider extends BaseProvider {
  KeranjangApi keranjangApi = KeranjangApi();
  RiwayatApi riwayatApi = RiwayatApi();

  KeranjangProvider() {
    init();
  }

  init() async {
    int idCurrent = await BaseProvider.getCurrentMemberId();
    getBarangsFromKeranjang(idUser: idCurrent);
    getTotalHarga(idUser: idCurrent);
    print('keranjangProvider created');
  }

  List<Barang> barangKeranjang;
  int _totalHarga = 0;
  int get totalHarga => _totalHarga;

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
      notifyListeners();
      init();
    }
    print('addToCart is done');
  }

  Future deleteFromCart({@required int idUser, @required int idBarang, @required Barang barang}) async {
    print('deleteFromCart is working');

    var response = await keranjangApi.deleteFromCart(idUser, idBarang);
    if (response) {
      barangKeranjang.remove(barang);
      notifyListeners();
      init();
    }
    print('deleteFromCart is done');
  }

  Future checkOut({@required int id, @required int durasi}) async {
    print('checkOut is working');

    setState(ViewState.Busy);
    var response = await riwayatApi.checkOutPesanan(id, durasi);
    if (response) {
      barangKeranjang.clear();
      init();
    }
    setState(ViewState.Idle);
    print('checkOut is done');
  }
}
