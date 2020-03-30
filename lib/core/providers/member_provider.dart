import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kamera_teman_client/locator.dart';
import 'package:kamera_teman_client/core/models/member.dart';
import 'package:kamera_teman_client/core/providers/base_provider.dart';
import 'package:kamera_teman_client/core/services/member_api.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';

class MemberProvider extends BaseProvider {
  MemberApi memberApi = locator<MemberApi>();

  MemberProvider() {
    getMembers();
  }

  List<Member> members;

  void getMembers() async {
    members = await memberApi.getMembers();
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

  void deleteMember({@required Member member}) async {
    int id = member.id;
    members.remove(member);
    try {
      await apiService.delete('member', id);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
