import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kamera_teman_client/core/models/member.dart';
import 'package:kamera_teman_client/core/providers/base_provider.dart';
import 'package:kamera_teman_client/core/services/member_api.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';
import 'package:kamera_teman_client/locator.dart';

class MemberProvider extends BaseProvider {
  MemberApi memberApi = locator<MemberApi>();

  List<Member> members;
  Member _currentMember;
  Member get currentMember => _currentMember;

  Future getCurrentMember() async {
    var idCurrent = await BaseProvider.getCurrentMemberId();
    try {
      _currentMember = await memberApi.getMemberById(idCurrent);
    } on Exception catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future addMember(
      {@required File imageFile,
      @required String nama,
      @required String alamat,
      @required String email,
      @required String phone,
      @required String password}) async {
    try {
      setState(ViewState.Busy);
      var isUploadSuccess = await memberApi.uploadMember(imageFile, nama, alamat, email, phone, password);
      setState(ViewState.Idle);

      return isUploadSuccess;
    } catch (e) {
      print(e);
    }
  }
}
