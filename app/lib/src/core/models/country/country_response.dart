import '../../../country_details/models/country.dart';
import 'country_error_type.dart';

class CountryResponse {
  final Country? country;
  final CountryResponseErrorType? error;
  final bool isSuccess;

  const CountryResponse({
    this.country,
    this.error,
    this.isSuccess = false,
  });

  CountryResponse copyWith({
    Country? countries,
    CountryResponseErrorType? error,
    bool? isSuccess,
  }) {
    return CountryResponse(
      country: countries ?? this.country,
      error: error ?? this.error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
