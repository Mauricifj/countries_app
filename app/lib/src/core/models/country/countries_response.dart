import '../../../home/models/country_simplified.dart';
import 'country_error_type.dart';

class CountriesResponse {
  final List<CountrySimplified>? countries;
  final CountryResponseErrorType? error;
  final bool isSuccess;

  const CountriesResponse({
    this.countries,
    this.error,
    this.isSuccess = false,
  });

  CountriesResponse copyWith({
    List<CountrySimplified>? countries,
    CountryResponseErrorType? error,
    bool? isSuccess,
  }) {
    return CountriesResponse(
      countries: countries ?? this.countries,
      error: error ?? this.error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
