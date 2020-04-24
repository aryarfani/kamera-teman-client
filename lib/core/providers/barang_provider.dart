import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kamera_teman_client/locator.dart';
import 'package:kamera_teman_client/core/models/barang.dart';
import 'package:kamera_teman_client/core/providers/base_provider.dart';
import 'package:kamera_teman_client/core/services/barang_api.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';

class BarangProvider extends BaseProvider {
  BarangApi barangApi = locator<BarangApi>();

  BarangProvider() {
    getBarangs();
  }

  //* This variable is to help searching
  //* _barangs is mutable and will show to screen
  //* _barangPure is immutable the backup of _barangs
  List<Barang> _barangPure;
  List<Barang> get barangCadangan => _barangPure;

  List<Barang> _barangs;
  List<Barang> get barangs => _barangs;

  void getBarangs() async {
    _barangs = await barangApi.getBarangs();
    _barangPure = _barangs;
    notifyListeners();
  }

  Future addBarang({
    @required File imageFile,
    @required String nama,
    @required String stock,
    @required String harga,
  }) async {
    try {
      setState(ViewState.Busy);
      var isUploadSuccess = await barangApi.uploadBarang(imageFile, nama, stock, harga);
      setState(ViewState.Idle);

      return isUploadSuccess;
    } catch (e) {
      print(e);
    }
  }

  void deleteBarang({@required Barang barang}) async {
    int id = barang.id;
    _barangs.remove(barang);

    try {
      await apiService.delete('barang', id);
    } on Exception catch (e) {
      print(e);
    }

    notifyListeners();
  }

  Future findBarang({@required String keyword}) async {
    if (keyword.trim().isNotEmpty) {
      _barangs = _barangPure.where((barang) => barang.nama.toLowerCase().contains(keyword.toLowerCase())).toList();
    }
    //* if empty will return prior list
    if (keyword.trim().isEmpty) {
      _barangs = _barangPure;
    }
    notifyListeners();
  }
}
