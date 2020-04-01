import 'package:http/http.dart' as http;
import 'package:kamera_teman_client/core/services/api.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';

class RiwayatApi {
  Future checkOutPesanan(int id) async {
    print('checkOutPesanan working');
    var res = await http.get(linkApi + 'checkOutPesanan/$id');
    if (res.statusCode == 200) {
      print('checkOutPesanan success');

      return true;
    } else {
      print('checkOutPesanan failed' + res.statusCode.toString());

      return false;
    }
  }

  Future getRiwayat(int id) async {
    var res = await http.get(linkApi + 'riwayat/$id');
    print('getRiwayat done');
    return ApiService.jsonToBarangList(res);
  }
}
