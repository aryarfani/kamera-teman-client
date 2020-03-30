import 'package:flutter/foundation.dart';
import 'package:kamera_teman_client/core/providers/base_provider.dart';
import 'package:kamera_teman_client/core/services/keranjang_api.dart';
import 'package:kamera_teman_client/locator.dart';

class KeranjangProvider extends BaseProvider {
  KeranjangApi keranjangApi = locator<KeranjangApi>();

  int _keranjangCount;

  Future addToCart({@required int idUser, @required int idBarang}) async {
    var response = await keranjangApi.addToCart(idUser, idBarang);
    if (response) {
      notifyListeners();
    }
  }
}
