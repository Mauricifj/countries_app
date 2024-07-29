import 'package:dio/dio.dart';

import '../models/http_body.dart';
import '../models/http_error.dart';
import '../models/http_response.dart';
import '../models/status_code_x.dart';

abstract interface class HttpService {
  Future<HttpResponse> get(
    Uri uri, {
    Map<String, dynamic>? headers,
  });
  Future<HttpResponse> post(
    Uri uri,
    HttpBody? data, {
    Map<String, dynamic>? headers,
  });
  Future<HttpResponse> patch(
    Uri uri, {
    HttpBody? data,
    Map<String, dynamic>? headers,
  });
  Future<HttpResponse> put(
    Uri uri, {
    HttpBody? data,
    Map<String, dynamic>? headers,
  });
  Future<HttpResponse> delete(
    Uri uri, {
    Map<String, dynamic>? headers,
  });
}

class DioService implements HttpService {
  final Dio _dio;

  DioService(this._dio);

  final contentTypeJson = {'Content-Type': 'application/json'};
  final defaultErrorMessage = 'An error occurred';

  @override
  Future<HttpResponse> get(
    Uri uri, {
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.getUri(
        uri,
        options: _buildOptions(headers),
      );
      return HttpResponse(
        data: response.data,
        isSuccessful: response.statusCode?.isSuccess == true,
        error: null,
      );
    } on DioException catch (e) {
      return buildErrorResponseFromDioException(e);
    } catch (e) {
      return _extractErrorResponseFromGeneralException(e);
    }
  }

  @override
  Future<HttpResponse> post(
    Uri uri,
    HttpBody? data, {
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.postUri(
        uri,
        data: data?.toJson(),
        options: _buildOptions(headers),
      );
      return HttpResponse(
        data: response.data,
        isSuccessful: response.statusCode?.isSuccess == true,
        error: null,
      );
    } on DioException catch (e) {
      return buildErrorResponseFromDioException(e);
    } catch (e) {
      return _extractErrorResponseFromGeneralException(e);
    }
  }

  @override
  Future<HttpResponse> patch(
    Uri uri, {
    HttpBody? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.patchUri(
        uri,
        data: data?.toJson(),
        options: _buildOptions(headers),
      );
      return HttpResponse(
        data: response.data,
        isSuccessful: response.statusCode?.isSuccess == true,
        error: null,
      );
    } on DioException catch (e) {
      return buildErrorResponseFromDioException(e);
    } catch (e) {
      return _extractErrorResponseFromGeneralException(e);
    }
  }

  @override
  Future<HttpResponse> put(
    Uri uri, {
    HttpBody? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.putUri(
        uri,
        data: data?.toJson(),
        options: _buildOptions(headers),
      );
      return HttpResponse(
        data: response.data,
        isSuccessful: response.statusCode?.isSuccess == true,
        error: null,
      );
    } on DioException catch (e) {
      return buildErrorResponseFromDioException(e);
    } catch (e) {
      return _extractErrorResponseFromGeneralException(e);
    }
  }

  @override
  Future<HttpResponse> delete(
    Uri uri, {
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.deleteUri(
        uri,
        options: _buildOptions(headers),
      );
      return HttpResponse(
        data: response.data,
        isSuccessful: response.statusCode?.isSuccess == true,
        error: null,
      );
    } on DioException catch (e) {
      return buildErrorResponseFromDioException(e);
    } catch (e) {
      return _extractErrorResponseFromGeneralException(e);
    }
  }

  Options _buildOptions(Map<String, dynamic>? headers) {
    return Options(
      headers: {
        ...contentTypeJson,
        ...?headers,
      },
    );
  }

  String _extractErrorMessage(DioException e) {
    final messageFromResponse = e.response?.data is Map<String, dynamic>
        ? e.response?.data['message']
        : null;

    final statusCode = e.response?.statusCode ?? 0;
    final messageFromStatus =
        statusCode < 200 && statusCode > 399 ? e.response?.statusMessage : null;

    final message =
        messageFromResponse ?? messageFromStatus ?? defaultErrorMessage;

    return message;
  }

  HttpResponse buildErrorResponseFromDioException(DioException e) {
    return HttpResponse(
      data: null,
      isSuccessful: e.response?.statusCode?.isSuccess == true,
      error: HttpError(
        message: _extractErrorMessage(e),
        type: HttpErrorType.fromStatusCode(e.response?.statusCode ?? 0),
      ),
    );
  }

  HttpResponse _extractErrorResponseFromGeneralException(Object e) {
    return HttpResponse(
      data: null,
      isSuccessful: false,
      error: HttpError(
        message: defaultErrorMessage,
        type: HttpErrorType.unknown,
      ),
    );
  }
}
