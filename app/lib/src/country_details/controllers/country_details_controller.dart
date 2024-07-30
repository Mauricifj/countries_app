import 'package:flutter/material.dart';

import '../../core/models/country/country_error_type.dart';
import '../../core/services/countries_service.dart';
import 'states/details_state.dart';

class CountryDetailsController extends ChangeNotifier {
  final CountriesService _countriesService;

  CountryDetailsController(this._countriesService);

  DetailsState _state = DetailsState.initial();
  DetailsState get state => _state;

  Future<void> getByCode(String code) async {
    final result = await _countriesService.getByCode(code);

    if (result.error != null) {
      _state = _state.copyWith(isLoading: false);
      switch (result.error) {
        case CountryResponseErrorType.notFound:
          _state = _state.copyWith(errorType: CountryErrorType.emptyData);
        case CountryResponseErrorType.serverError:
          _state = _state.copyWith(errorType: CountryErrorType.serverError);
        default:
          _state = _state.copyWith(errorType: CountryErrorType.unknown);
      }
      notifyListeners();
      return;
    }

    final resultBorders = await _countriesService.searchByCode(
      result.country?.borders ?? [],
    );

    _state = _state.copyWith(
      country: result.country?.copyWith(
          borders: resultBorders.countries
              ?.map(
                (e) => e.commonName,
              )
              .toList()),
      isLoading: false,
      errorType: null,
    );
    notifyListeners();
  }
}
