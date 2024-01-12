import 'package:dio/dio.dart';
import 'package:kiwi/kiwi.dart';
import 'package:stp/service/api_service.dart';
import 'package:stp/service/auth_service.dart';

void setupContainer() {
  final container = KiwiContainer();

  container.registerFactory((c) => Dio());
  container.registerFactory((c) => ApiService(c.resolve<Dio>()));
  container.registerFactory((c) => AuthService());
}
