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

  String _message;
  String get message => _message;
  String _namaCurrent;
  String get namaCurrent => _namaCurrent;
  int _idCurrent;
  int get idCurrent => _idCurrent;

  Future login({@required String email, @required String password}) async {
    setState(ViewState.Busy);
    Response result = await apiService.login(email, password);
    print(result.body);

    if (result.statusCode == 200) {
      _message = '';
      var apiResponse = json.decode(result.body);

      //* wait till user data saved to SharedPreferences
      if (await storeUserData(apiResponse['id'], apiResponse['nama']) == true) {
        print('user data saved done');
        return result.statusCode;
      }
    } else if (result.statusCode == 401) {
      _message = 'Email atau password salah';
    } else {
      _message = 'Login gagal, cek koneksi internet';
    }

    setState(ViewState.Idle);
  }

  Future<bool> storeUserData(int id, String nama) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    _namaCurrent = nama;
    _idCurrent = id;
    await storage.setString('namaMember', nama);
    await storage.setInt('idMember', id);
    return true;
  }

  void getUserData() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    _idCurrent = storage.get('idMember');
    _namaCurrent = storage.getString('namaMember');
    notifyListeners();
  }
}
