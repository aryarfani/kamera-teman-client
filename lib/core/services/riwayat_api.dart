import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kamera_teman_client/core/services/api.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';

class RiwayatApi {
  Future checkOutPesanan(int id, int durasi) async {
    print('checkOutPesanan working');
    var res = await http.post(linkApi + 'checkOutPesanan/$id', body: {'durasi': durasi.toString()});
    if (res.statusCode == 200) {
      print('checkOutPesanan success');
      Map<String, String> headers = {
        "Authorization":
            "key=AAAAwZJsvEg:APA91bHPeMKaQ0mhXIChaEbV36WnnG7qmc12NJLgWkBBbVd-2LsmUojjlg3KTH1dCcLKLBYKjc1B1U2Ytv5oi-VZRNt4n-MCm5DjbhSL8DWVaI4ene9F0ZDJR5Tm92hpfXOk6j0auNNF",
        "Content-Type": "application/json"
      };
      final body = jsonEncode({
        "to":
            "dQmie4vpQZGfS1dnuQXLxl:APA91bFZujvNDDGNCSNbQnL1KK7ey0UQz9K-TridrVJMOjCiJb6RaKjgbmptonXYazeepRfoCQxA-z6Ycu7mlDZ3dcCf6jarTflNjgq9SU8H5e08X3ttjPuBjqLWlWQ0pcI4EJF0B6kR",
        "notification": {
          "body": "Kamera Teman",
          "title": "Barang memerlukan konfirmasi",
        },
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
        }
      });
      var res = await http.post('https://fcm.googleapis.com/fcm/send', headers: headers, body: body);
      if (res.statusCode == 200) {
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
