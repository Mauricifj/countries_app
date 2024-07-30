import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'authentication/services/auth_service.dart';
import 'authentication/services/storage_service.dart';
import 'core/services/http_service.dart';
import 'core/services/countries_service.dart';

final serviceLocator = GetIt.instance;

void setup() {
  serviceLocator.registerFactory<HttpService>(
    () => DioService(Dio()),
  );

  serviceLocator.registerFactory<AuthService>(
    () => AuthServiceImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<StorageService>(
    () => SharedPreferencesService(),
  );

  serviceLocator.registerFactory<CountriesService>(
    () => CountriesServiceImpl(
      serviceLocator(),
    ),
  );
}
