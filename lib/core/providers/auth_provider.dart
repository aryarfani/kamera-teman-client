import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:kamera_teman_client/locator.dart';
import 'package:kamera_teman_client/core/providers/base_provider.dart';
import 'package:kamera_teman_client/core/services/api.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends BaseProvider {
  ApiService apiService = locator<ApiService>();

  AuthProvider() {
    getUserData();
    print('getUserData is working');
  }

  String message;
  String namaCurrent;
  String idCurrent;

  Future login({@required String email, @required String password}) async {
    setState(ViewState.Busy);
    Response result = await apiService.login(email, password);

    if (result.statusCode == 200) {
      message = '';
      var apiResponse = json.decode(result.body);
      storeUserData(apiResponse['id'], apiResponse['nama']);
    } else if (result.statusCode == 401) {
      message = 'Email atau password salah';
    } else {
      message = 'Login gagal, cek koneksi internet';
    }

    setState(ViewState.Idle);

    return result.statusCode;
  }

  void storeUserData(int id, String nama) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setInt('idMember', id);
    await storage.setString('namaMember', nama);
  }

  void getUserData() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    namaCurrent = storage.get('id');
    idCurrent = storage.getString('nama');
  }
}
