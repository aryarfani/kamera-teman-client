import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kamera_teman_client/core/models/barang.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';

class KeranjangApi {
  Future getJumlahBarangFromKeranjang(int id) async {
    print('getJumlah working $id');
    var res = await http.get(linkApi + 'jumlahBarangKeranjang/$id');
    if (res.statusCode == 200) {
      return json.decode(res.body);
    }
  }

  Future getAllFromKeranjang(int id) async {
    var res = await http.get(linkApi + 'keranjang/$id');
    var jsonObject = await json.decode(res.body);
    print(res.body);
    List<dynamic> dataJson = jsonObject;
    List<Barang> barangs = [];

    for (var data in dataJson) barangs.add(Barang.fromJson(data));
    print('getAllFromKeranjang done');
    return barangs;
  }

  Future addToCart(int idUser, int idBarang) async {
    Map<String, int> body = {
      'id_barang': idBarang,
    };

    final response = await http.post(linkApi + 'keranjang/$idUser', body: body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to addToCart');
    }
  }

  Future deleteToCart(int idUser, int idBarang) async {
    Map<String, int> body = {
      'idBarang': idBarang,
    };

    final response = await http.post(linkApi + 'keranjang/$idUser', body: body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to addToCart');
    }
  }
}
