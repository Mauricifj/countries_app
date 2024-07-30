import 'package:flutter/material.dart';

import '../../core/models/country/country_error_type.dart';
import '../../core/services/countries_service.dart';
import 'states/home_state.dart';

class HomeController extends ChangeNotifier {
  final CountriesService _countriesService;

  HomeController(this._countriesService) {
    getCountries();
  }

  HomeState _state = HomeState.initial();
  HomeState get state => _state;

  Future<void> getCountries() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _countriesService.getAll();
    final error = result.error;
    if (error != null) {
      _state = _state.copyWith(isLoading: false);
      switch (error) {
        case CountryResponseErrorType.notFound:
          _state = _state.copyWith(errorType: HomeErrorType.emptyData);
        case CountryResponseErrorType.serverError:
          _state = _state.copyWith(errorType: HomeErrorType.serverError);
        default:
          _state = _state.copyWith(errorType: HomeErrorType.unknown);
      }
      notifyListeners();
      return;
    }

    _state = _state.copyWith(
      countries: result.countries,
      isLoading: false,
      errorType: null,
    );
    notifyListeners();
  }
}
