import 'package:countries_app/src/core/models/country/countries_response.dart';
import 'package:countries_app/src/core/models/country/country_error_type.dart';
import 'package:countries_app/src/core/models/country/country_response.dart';
import 'package:countries_app/src/core/services/countries_service.dart';
import 'package:countries_app/src/country_details/controllers/country_details_controller.dart';
import 'package:countries_app/src/country_details/models/country.dart';
import 'package:countries_app/src/home/models/country_simplified.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCountriesService extends Mock implements CountriesService {}

void main() {
  group('CountryDetailsController', () {
    late CountryDetailsController controller;
    late MockCountriesService mockCountriesService;

    const countryCode = 'BRA';

    setUp(() {
      mockCountriesService = MockCountriesService();
      controller = CountryDetailsController(mockCountriesService);
    });

    test('getByCode() should call countriesService.getByCode with correct code',
        () async {
      // Arrange
      when(
        () => mockCountriesService.getByCode(countryCode),
      ).thenAnswer(
        (_) async => const CountryResponse(
          country: null,
          error: CountryResponseErrorType.notFound,
          isSuccess: false,
        ),
      );

      // Act
      await controller.getByCode(countryCode);

      // Assert
      verify(
        () => mockCountriesService.getByCode(countryCode),
      ).called(1);
    });

    test('getByCode() should set country to null if request is unsuccessful',
        () async {
      // Arrange
      when(
        () => mockCountriesService.getByCode(countryCode),
      ).thenAnswer(
        (_) async => const CountryResponse(
          country: null,
          error: CountryResponseErrorType.notFound,
          isSuccess: false,
        ),
      );

      // Act
      await controller.getByCode(countryCode);

      // Assert
      expect(controller.state.country, isNull);
    });

    test(
        'getByCode() should set country to the returned country if request is successful',
        () async {
      // Arrange
      final borders = [
        'ARG',
        'BOL',
        'COL',
        'GUF',
        'GUY',
        'PRY',
        'PER',
        'SUR',
        'URY',
        'VEN'
      ];

      final country = Country(
        code: countryCode,
        commonName: 'Brazil',
        officialName: 'Federative Republic of Brazil',
        flagUrl: 'https://flagcdn.com/w320/br.png',
        currencies: ['Brazilian real (R\$)'],
        languages: ['Portuguese'],
        capital: 'Brasília',
        borders: borders,
        googleMapsUrl: 'https://goo.gl/maps/waCKk21HeeqFzkNC9',
        continents: ['South America'],
      );

      when(
        () => mockCountriesService.getByCode(countryCode),
      ).thenAnswer(
        (_) async => CountryResponse(
          isSuccess: true,
          country: country,
          error: null,
        ),
      );

      when(
        () => mockCountriesService.searchByCode(borders),
      ).thenAnswer(
        (_) async => CountriesResponse(
          isSuccess: true,
          countries: borders
              .map(
                (e) => CountrySimplified(
                  code: e,
                  commonName: e,
                  officialName: e,
                  flag: 'https://flagcdn.com/w320/$e.png',
                ),
              )
              .toList(),
          error: null,
        ),
      );

      // Act
      await controller.getByCode(countryCode);

      // Assert
      expect(controller.state.country, country);
    });
  });
}
