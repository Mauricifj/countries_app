import 'http_error.dart';

class HttpResponse {
  final dynamic data;
  final bool isSuccessful;
  final HttpError? error;

  HttpResponse({
    required this.data,
    required this.isSuccessful,
    this.error,
  });
}
