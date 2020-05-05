import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kamera_teman_client/core/services/api.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';

class KeranjangApi {
  Future getBarangsFromKeranjang(int id) async {
    var res = await http.get(linkApi + 'keranjang/$id');
    print('getBarangsFromKeranjang done');
    return ApiService.jsonToBarangList(res);
  }

  Future addToCart(int idUser, int idBarang) async {
    print(idUser.toString());
    Map<String, String> body = {
      'id_barang': idBarang.toString(),
    };

    final response = await http.post(linkApi + 'keranjang/$idUser', body: body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to addToCart');
    }
  }

  Future deleteFromCart(int idUser, int idBarang) async {
    Map<String, String> body = {
      'id_barang': idBarang.toString(),
    };

    final response = await http.post(linkApi + 'keranjang/$idUser/delete', body: body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to addToCart');
    }
  }

  Future getTotalHarga(int idUser) async {
    var res = await http.get(linkApi + 'keranjang/$idUser/harga');
    if (res.statusCode == 200) {
      return json.decode(res.body);
    }
  }
}
