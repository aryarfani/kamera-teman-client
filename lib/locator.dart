import 'package:get_it/get_it.dart';
import 'package:kamera_teman_client/core/providers/auth_provider.dart';
import 'package:kamera_teman_client/core/providers/barang_provider.dart';
import 'package:kamera_teman_client/core/providers/keranjang_provider.dart';
import 'package:kamera_teman_client/core/providers/member_provider.dart';
import 'package:kamera_teman_client/core/services/api.dart';
import 'package:kamera_teman_client/core/services/barang_api.dart';
import 'package:kamera_teman_client/core/services/image.dart';
import 'package:kamera_teman_client/core/services/member_api.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => BarangProvider());
  locator.registerFactory(() => MemberProvider());
  locator.registerFactory(() => KeranjangProvider());

  locator.registerLazySingleton(() => ImageService());
  locator.registerLazySingleton(() => AuthProvider());
  locator.registerLazySingleton(() => MemberApi());
  locator.registerLazySingleton(() => BarangApi());
  locator.registerLazySingleton(() => ApiService());
}
