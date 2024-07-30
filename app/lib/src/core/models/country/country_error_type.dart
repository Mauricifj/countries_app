enum CountryResponseErrorType {
  notFound,
  serverError,
  unknown;

  String get message {
    switch (this) {
      case notFound:
        return 'Not found';
      case serverError:
        return 'Server Error';
      case unknown:
        return 'Unknown Error';
    }
  }
}
