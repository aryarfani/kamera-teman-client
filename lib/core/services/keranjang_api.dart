import 'package:http/http.dart' as http;
import 'package:kamera_teman_client/core/utils/constant.dart';

class KeranjangApi {
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
