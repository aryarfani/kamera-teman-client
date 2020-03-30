import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:kamera_teman_client/locator.dart';
import 'package:kamera_teman_client/core/providers/base_provider.dart';
import 'package:kamera_teman_client/core/services/api.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends BaseProvider {
  AuthProvider() {
    getUserData();
  }
  ApiService apiService = locator<ApiService>();

  String message;
  String namaCurrent;
  int idCurrent;

  Future login({@required String email, @required String password}) async {
    setState(ViewState.Busy);
    Response result = await apiService.login(email, password);

    if (result.statusCode == 200) {
      message = '';
      var apiResponse = json.decode(result.body);
      print('waiting ');
      //* wait till user data saved to SharedPreferences
      if (await storeUserData(apiResponse['id'], apiResponse['nama']) == true) {
        print('waiting done');
        return result.statusCode;
      }
    } else if (result.statusCode == 401) {
      message = 'Email atau password salah';
    } else {
      message = 'Login gagal, cek koneksi internet';
    }

    setState(ViewState.Idle);
  }

  Future<bool> storeUserData(int id, String nama) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    namaCurrent = nama;
    idCurrent = id;
    await storage.setString('namaMember', nama);
    await storage.setInt('idMember', id);
    return true;
  }

  void getUserData() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    idCurrent = storage.get('idMember');
    namaCurrent = storage.getString('namaMember');
    notifyListeners();
  }
}
