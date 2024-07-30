enum Env {
  authHost,
  countriesHost,
  countriesHostVersion;

  static const String _authHostKey = 'AUTH_HOST';
  static const String _countriesHostKey = 'COUNTRIES_HOST';
  static const String _countriesHostVersionKey = 'COUNTRIES_HOST_VERSION';

  static const String _authHost = String.fromEnvironment(_authHostKey);
  static const String _countriesHost =
      String.fromEnvironment(_countriesHostKey);
  static const String _countriesHostVersion =
      String.fromEnvironment(_countriesHostVersionKey);

  String get value {
    switch (this) {
      case countriesHost:
        return _countriesHost;
      case countriesHostVersion:
        return _countriesHostVersion;
      case authHost:
        return _authHost;
    }
  }
}
