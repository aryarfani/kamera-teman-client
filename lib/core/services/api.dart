import 'dart:convert';

import 'package:kamera_teman_client/core/models/barang.dart';
import 'package:kamera_teman_client/core/models/barang_riwayat.dart';
import 'package:kamera_teman_client/locator.dart';
import 'package:kamera_teman_client/core/services/image.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';

class ApiService {
  ImageService imageService = locator<ImageService>();

  Future delete(String type, int id) async {
    print('delete is working');

    var url = Uri.parse(linkApi + '$type' + '/$id');
    var request = http.MultipartRequest('POST', url);
    request.fields['_method'] = 'delete';

    var res = await request.send();

    print('delete $id done');
    if (res.statusCode == 200) {
      showToast('Berhasil dihapus');
      return true;
    }

    return false;
  }

  Future login(String email, String password) async {
    var url = Uri.parse(linkApi + 'loginMember');
    var res = await http.post(url, body: {
      'email': email,
      'password': password,
    });
    return res;
  }

  static Future<List<Barang>> jsonToBarangList(http.Response res) async {
    var jsonObject = await json.decode(res.body);
    if (jsonObject == []) {
      return null;
    }
    List<dynamic> dataJson = jsonObject;
    List<Barang> barangs = [];

    for (var data in dataJson) barangs.add(Barang.fromJson(data));
    return barangs;
  }

  static Future<List<BarangRiwayat>> jsonToBarangRiwayatList(http.Response res) async {
    var jsonObject = await json.decode(res.body);
    if (jsonObject == []) {
      return [];
    }
    List<dynamic> dataJson = jsonObject;
    List<BarangRiwayat> barangs = [];

    for (var data in dataJson) barangs.add(BarangRiwayat.fromJson(data));
    return barangs;
  }
}
