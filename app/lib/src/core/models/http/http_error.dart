class HttpError {
  final String message;
  final HttpErrorType type;

  HttpError({
    required this.message,
    required this.type,
  });
}

enum HttpErrorType {
  notFound,
  unauthorized,
  forbidden,
  badRequest,
  internalServerError,
  unknown;

  factory HttpErrorType.fromStatusCode(int statusCode) {
    switch (statusCode) {
      case 404:
        return HttpErrorType.notFound;
      case 401:
        return HttpErrorType.unauthorized;
      case 403:
        return HttpErrorType.forbidden;
      case 400:
        return HttpErrorType.badRequest;
      case >=500 && <=599:
        return HttpErrorType.internalServerError;
      default:
        return HttpErrorType.unknown;
    }
  }
}
