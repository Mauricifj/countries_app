import 'package:flutter/material.dart';

import '../models/countries_response.dart';
import '../services/countries_service.dart';
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

    if (result.error != null) {
      _state = _state.copyWith(isLoading: false);
      switch (result.error) {
        case CountriesErrorType.notFound:
          _state = _state.copyWith(errorType: HomeErrorType.emptyData);
        case CountriesErrorType.serverError:
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
