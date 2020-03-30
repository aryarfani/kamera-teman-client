import 'package:flutter/foundation.dart';
import 'package:kamera_teman_client/locator.dart';
import 'package:kamera_teman_client/core/services/api.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';

class BaseProvider extends ChangeNotifier {
  ApiService apiService = locator<ApiService>();

  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
