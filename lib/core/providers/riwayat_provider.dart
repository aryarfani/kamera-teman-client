import 'package:kamera_teman_client/core/models/barang.dart';
import 'package:kamera_teman_client/core/providers/base_provider.dart';
import 'package:kamera_teman_client/core/services/riwayat_api.dart';
import 'package:kamera_teman_client/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiwayatProvider extends BaseProvider {
  RiwayatApi riwayatApi = locator<RiwayatApi>();

  List<Barang> unconfirmedRiwayat;

  void getUncofirmedRiwayat() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    int idCurrent = storage.get('idMember');
    print('getUncofirmedRiwayat');
    unconfirmedRiwayat = await riwayatApi.getRiwayat(idCurrent);
    notifyListeners();
  }
}
