import 'package:http/http.dart' as http;
import 'package:kamera_teman_client/core/services/api.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';

class RiwayatApi {
  Future checkOutPesanan(int id, int durasi) async {
    print('checkOutPesanan working');
    var res = await http.post(linkApi + 'checkOutPesanan/$id', body: {'durasi': durasi.toString()});
    if (res.statusCode == 200) {
      print('checkOutPesanan success');

      return true;
    } else {
      print('checkOutPesanan failed' + res.statusCode.toString());

      return false;
    }
  }

  Future getRiwayat(int id) async {
    var res = await http.get(linkApi + 'getAllMemberRiwayat/$id');
    print('getRiwayat done');
    return ApiService.jsonToBarangRiwayatList(res);
  }

  Future getUncofirmedMemberRiwayat(int id) async {
    var res = await http.get(linkApi + 'getUncofirmedMemberRiwayat/$id');
    print('getUncofirmedMemberRiwayat done');
    return ApiService.jsonToBarangRiwayatList(res);
  }

  Future getBorrowedMemberRiwayat(int id) async {
    var res = await http.get(linkApi + 'getBorrowedMemberRiwayat/$id');
    print('getBorrowedMemberRiwayat done');
    return ApiService.jsonToBarangRiwayatList(res);
  }

  Future getDoneAndCancelledMemberRiwayat(int id) async {
    var res = await http.get(linkApi + 'getDoneAndCancelledMemberRiwayat/$id');
    print('getDoneAndCancelledMemberRiwayat done');
    return ApiService.jsonToBarangRiwayatList(res);
  }
}
