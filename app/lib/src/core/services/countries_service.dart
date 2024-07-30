import '../../country_details/models/country.dart';
import '../../home/models/country_simplified.dart';
import '../env/env.dart';
import '../models/country/countries_response.dart';
import '../models/country/country_error_type.dart';
import '../models/country/country_response.dart';
import '../models/http/http_error.dart';
import 'http_service.dart';

abstract interface class CountriesService {
  Future<CountriesResponse> getAll();
  Future<CountryResponse> getByCode(String code);
  Future<CountriesResponse> searchByCode(List<String> codes);
}

class CountriesServiceImpl implements CountriesService {
  final HttpService service;

  CountriesServiceImpl(this.service);

  final String version = '/v${Env.countriesHostVersion.value}';

  Uri _baseUri(
    CountriesServiceEndpoint endpoint, {
    String? path,
    Map<String, dynamic>? queryParameters,
  }) =>
      Uri.https(
        Env.countriesHost.value,
        version + endpoint.value + (path != null ? '/$path' : ''),
        queryParameters,
      );

  final fieldsKey = 'fields';

  Map<String, dynamic> get queryParametersForSimplified => {
        fieldsKey: 'cca3,name,flags',
      };

  Map<String, dynamic> get queryParametersForDetailed => {
        fieldsKey:
            'cca3,name,flags,languages,borders,currencies,capital,maps,continents',
      };

  @override
  Future<CountriesResponse> getAll() async {
    final result = await service.get(
      _baseUri(
        CountriesServiceEndpoint.all,
        queryParameters: queryParametersForSimplified,
      ),
    );

    if (result.error != null) {
      switch (result.error!.type) {
        case HttpErrorType.notFound:
        case HttpErrorType.badRequest:
          return const CountriesResponse(
            countries: null,
            error: CountryResponseErrorType.notFound,
            isSuccess: false,
          );
        case HttpErrorType.forbidden:
        case HttpErrorType.unauthorized:
        case HttpErrorType.internalServerError:
          return const CountriesResponse(
            countries: null,
            error: CountryResponseErrorType.serverError,
            isSuccess: false,
          );
        default:
          return const CountriesResponse(
            countries: null,
            error: CountryResponseErrorType.unknown,
            isSuccess: false,
          );
      }
    }

    final countries = result.data as List?;

    return CountriesResponse(
      error: result.isSuccessful ? null : CountryResponseErrorType.unknown,
      countries: result.isSuccessful
          ? countries?.map((e) => CountrySimplified.fromJson(e)).toList()
          : null,
      isSuccess: result.isSuccessful,
    );
  }

  @override
  Future<CountryResponse> getByCode(String code) async {
    final result = await service.get(
      _baseUri(
        CountriesServiceEndpoint.byCode,
        path: code,
        queryParameters: queryParametersForDetailed,
      ),
    );

    if (result.error != null) {
      switch (result.error!.type) {
        case HttpErrorType.notFound:
        case HttpErrorType.badRequest:
          return const CountryResponse(
            country: null,
            error: CountryResponseErrorType.notFound,
            isSuccess: false,
          );
        case HttpErrorType.forbidden:
        case HttpErrorType.unauthorized:
        case HttpErrorType.internalServerError:
          return const CountryResponse(
            country: null,
            error: CountryResponseErrorType.serverError,
            isSuccess: false,
          );
        default:
          return const CountryResponse(
            country: null,
            error: CountryResponseErrorType.unknown,
            isSuccess: false,
          );
      }
    }

    final country = result.data as Map<String, dynamic>?;

    return CountryResponse(
      country: country != null ? Country.fromJson(country) : null,
      error: result.isSuccessful ? null : CountryResponseErrorType.unknown,
      isSuccess: result.isSuccessful,
    );
  }

  @override
  Future<CountriesResponse> searchByCode(List<String> codes) async {
    final result = await service.get(
      _baseUri(
        CountriesServiceEndpoint.byCode,
        queryParameters: {
          ...queryParametersForSimplified,
          'codes': codes,
        },
      ),
    );

    if (result.error != null) {
      switch (result.error!.type) {
        case HttpErrorType.notFound:
        case HttpErrorType.badRequest:
          return const CountriesResponse(
            countries: null,
            error: CountryResponseErrorType.notFound,
            isSuccess: false,
          );
        case HttpErrorType.forbidden:
        case HttpErrorType.unauthorized:
        case HttpErrorType.internalServerError:
          return const CountriesResponse(
            countries: null,
            error: CountryResponseErrorType.serverError,
            isSuccess: false,
          );
        default:
          return const CountriesResponse(
            countries: null,
            error: CountryResponseErrorType.unknown,
            isSuccess: false,
          );
      }
    }

    final countries = result.data as List?;

    return CountriesResponse(
      countries: countries
          ?.map(
            (e) => CountrySimplified.fromJson(e),
          )
          .toList(),
      error: result.isSuccessful ? null : CountryResponseErrorType.unknown,
      isSuccess: result.isSuccessful,
    );
  }
}

enum CountriesServiceEndpoint {
  all,
  byCode;

  String get value {
    switch (this) {
      case all:
        return '/all';
      case byCode:
        return '/alpha';
    }
  }
}
