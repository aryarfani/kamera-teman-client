import 'package:flutter/foundation.dart';
import 'package:kamera_teman_client/core/services/api.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseProvider extends ChangeNotifier {
  ApiService apiService = ApiService();

  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  static Future<int> getCurrentMemberId() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    int idCurrent = storage.get('idMember');
    return idCurrent;
  }
}
