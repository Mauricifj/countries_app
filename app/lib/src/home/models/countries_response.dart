import 'country_simplified.dart';

class CountriesResponse {
  final List<CountrySimplified>? countries;
  final CountriesErrorType? error;
  final bool isSuccess;

  const CountriesResponse({
    this.countries,
    this.error,
    this.isSuccess = false,
  });

  CountriesResponse copyWith({
    List<CountrySimplified>? countries,
    CountriesErrorType? error,
    bool? isSuccess,
  }) {
    return CountriesResponse(
      countries: countries ?? this.countries,
      error: error ?? this.error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

enum CountriesErrorType {
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
