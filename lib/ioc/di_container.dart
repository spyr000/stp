import 'package:firebase_auth/firebase_auth.dart';
import 'package:kiwi/kiwi.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stp/auth/auth_service.dart';
import '../navigation/router.dart';
import '../service/api_service.dart';

void setupContainer()  {
  final container = KiwiContainer();

  container.registerFactory((c) => Dio());
  container.registerFactory((c) => ApiService(c.resolve<Dio>()));
  container.registerFactory((c) => PageRouter(apiService: c.resolve<ApiService>()));
  container.registerFactory((c) => AuthService());
}