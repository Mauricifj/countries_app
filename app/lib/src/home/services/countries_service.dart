import '../../core/env/env.dart';
import '../../core/models/http_error.dart';
import '../../core/services/http_service.dart';
import '../models/countries_response.dart';
import '../models/country_simplified.dart';

abstract interface class CountriesService {
  Future<CountriesResponse> getAll();
}

class CountriesServiceImpl implements CountriesService {
  final HttpService service;

  CountriesServiceImpl(this.service);

  final String version = '/v${Env.countriesHostVersion.value}';

  Uri _baseUri(
    CountriesServiceEndpoint endpoint,
    Map<String, dynamic> queryParameters,
  ) =>
      Uri.https(
        Env.countriesHost.value,
        version + endpoint.value,
        queryParameters,
      );

  final fieldsKey = 'fields';

  Map<String, dynamic> get queryParametersForSimplified => {
        fieldsKey: 'name,flags,languages,cca3',
      };

  Map<String, dynamic> get queryParametersForDetailed => {
        fieldsKey: 'name;alpha2Code;alpha3Code;flags',
      };

  @override
  Future<CountriesResponse> getAll() async {
    final result = await service.get(
      _baseUri(
        CountriesServiceEndpoint.all,
        queryParametersForSimplified,
      ),
    );

    if (result.error != null) {
      switch (result.error!.type) {
        case HttpErrorType.notFound:
        case HttpErrorType.badRequest:
          return const CountriesResponse(
            countries: null,
            error: CountriesErrorType.notFound,
            isSuccess: false,
          );
        case HttpErrorType.forbidden:
        case HttpErrorType.unauthorized:
        case HttpErrorType.internalServerError:
          return const CountriesResponse(
            countries: null,
            error: CountriesErrorType.serverError,
            isSuccess: false,
          );
        default:
          return const CountriesResponse(
            countries: null,
            error: CountriesErrorType.unknown,
            isSuccess: false,
          );
      }
    }
    final countries = result.data as List?;

    return CountriesResponse(
      error: result.isSuccessful ? null : CountriesErrorType.unknown,
      countries: result.isSuccessful
          ? countries?.map((e) => CountrySimplified.fromJson(e)).toList()
          : null,
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
