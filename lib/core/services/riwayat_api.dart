import 'package:http/http.dart' as http;
import 'package:kamera_teman_client/core/services/api.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';

class RiwayatApi {
  // Function to check out all barang from keranjang to unconfirmed riwayat
  Future checkOutPesanan(int id, int durasi) async {
    print('checkOutPesanan working');
    var res = await http.post(linkApi + 'keranjang/$id/checkout', body: {'durasi': durasi.toString()});

    if (res.statusCode == 200) {
      print('checkOutPesanan success');

      // if check out success send notif
      var notifRes = await ApiService.sendNotif("Barang memerlukan konfirmasi");
      if (notifRes.statusCode == 200) {
        print("notification sent");
      } else {
        print("notification failed");
      }

      return true;
    } else {
      print('checkOutPesanan failed' + res.statusCode.toString());
      return false;
    }
  }

  Future getRiwayat(int id) async {
    var res = await http.get(linkApi + 'riwayat/$id');
    print('getRiwayat done');
    return ApiService.jsonToBarangRiwayatList(res);
  }

  Future getUncofirmedMemberRiwayat(int id) async {
    var res = await http.get(linkApi + 'riwayat/$id/uncofirmed');
    print('getUncofirmedMemberRiwayat done');
    return ApiService.jsonToBarangRiwayatList(res);
  }

  Future getBorrowedMemberRiwayat(int id) async {
    var res = await http.get(linkApi + 'riwayat/$id/borrowed');
    print('getBorrowedMemberRiwayat done');
    return ApiService.jsonToBarangRiwayatList(res);
  }

  Future getDoneAndCancelledMemberRiwayat(int id) async {
    var res = await http.get(linkApi + 'riwayat/$id/doneandcancelled');
    print('getDoneAndCancelledMemberRiwayat done');
    return ApiService.jsonToBarangRiwayatList(res);
  }
}
