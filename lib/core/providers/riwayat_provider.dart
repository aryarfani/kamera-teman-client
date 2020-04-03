import 'package:kamera_teman_client/core/models/barang_riwayat.dart';
import 'package:kamera_teman_client/core/providers/base_provider.dart';
import 'package:kamera_teman_client/core/services/riwayat_api.dart';
import 'package:kamera_teman_client/locator.dart';

class RiwayatProvider extends BaseProvider {
  RiwayatApi riwayatApi = locator<RiwayatApi>();

  List<BarangRiwayat> unconfirmedRiwayat;
  List<BarangRiwayat> borrowedRiwayat;
  List<BarangRiwayat> doneAndCancelledRiwayat;

  void getUncofirmedRiwayat() async {
    int idCurrent = await BaseProvider.getCurrentMemberId();
    print('getUncofirmedRiwayat doin');
    unconfirmedRiwayat = await riwayatApi.getUncofirmedMemberRiwayat(idCurrent);
    notifyListeners();
  }

  void getBorrowedMemberRiwayat() async {
    int idCurrent = await BaseProvider.getCurrentMemberId();
    print('getAllBorrowedMemberRiwayat doing');
    borrowedRiwayat = await riwayatApi.getBorrowedMemberRiwayat(idCurrent);
    notifyListeners();
  }

  void getDoneAndCancelledMemberRiwayat() async {
    int idCurrent = await BaseProvider.getCurrentMemberId();
    print('getDoneAndCancelledMemberRiwayat doing');
    doneAndCancelledRiwayat = await riwayatApi.getDoneAndCancelledMemberRiwayat(idCurrent);
    notifyListeners();
  }
}
