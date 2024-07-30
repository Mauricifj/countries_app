import '../../models/country.dart';

class DetailsState {
  final bool isLoading;
  final Country? country;
  final CountryErrorType? error;

  DetailsState({
    this.isLoading = false,
    this.country,
    this.error,
  });

  factory DetailsState.initial() {
    return DetailsState(isLoading: true, country: null, error: null);
  }

  DetailsState copyWith({
    bool? isLoading,
    Country? country,
    CountryErrorType? errorType,
  }) {
    return DetailsState(
      isLoading: isLoading ?? this.isLoading,
      country: country ?? this.country,
      error: errorType ?? error,
    );
  }
}

enum CountryErrorType {
  unknown,
  noInternet,
  serverError,
  emptyData;

  String get message {
    switch (this) {
      case noInternet:
        return 'No internet connection';
      case serverError:
        return 'Server error';
      case emptyData:
        return 'No data available';
      default:
        return 'Unknown error';
    }
  }
}
