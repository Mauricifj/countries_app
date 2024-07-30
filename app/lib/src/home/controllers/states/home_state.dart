import '../../models/country_simplified.dart';

class HomeState {
  final bool isLoading;
  final List<CountrySimplified>? countries;
  final HomeErrorType? error;

  HomeState({
    this.isLoading = false,
    this.countries,
    this.error,
  });

  factory HomeState.initial() {
    return HomeState(isLoading: false, countries: null, error: null);
  }

  HomeState copyWith({
    bool? isLoading,
    List<CountrySimplified>? countries,
    HomeErrorType? errorType,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      countries: countries ?? this.countries,
      error: errorType ?? error,
    );
  }
}

enum HomeErrorType {
  unknown,
  noInternet,
  serverError,
  emptyData;

  String get message {
    switch (this) {
      case HomeErrorType.noInternet:
        return 'No internet connection';
      case HomeErrorType.serverError:
        return 'Server error';
      case HomeErrorType.emptyData:
        return 'No data available';
      default:
        return 'Unknown error';
    }
  }
}
