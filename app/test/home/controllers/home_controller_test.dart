import 'package:countries_app/src/core/models/country/countries_response.dart';
import 'package:countries_app/src/core/models/country/country_error_type.dart';
import 'package:countries_app/src/core/services/countries_service.dart';
import 'package:countries_app/src/home/controllers/home_controller.dart';
import 'package:countries_app/src/home/models/country_simplified.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCountriesService extends Mock implements CountriesService {}

void main() {
  group('HomeController', () {
    late HomeController controller;
    late MockCountriesService mockCountriesService;

    setUp(() {
      mockCountriesService = MockCountriesService();
      // controller = HomeController(mockCountriesService);
    });

    test(
      'getCountries() should call countriesService.getAll()',
      () async {
        // Arrange
        when(
          () => mockCountriesService.getAll(),
        ).thenAnswer(
          (_) async => const CountriesResponse(
            isSuccess: true,
            countries: [],
            error: null,
          ),
        );

        // Act

        controller = HomeController(mockCountriesService);
        await controller.getCountries();

        // Assert
        verify(
          () => mockCountriesService.getAll(),
        ).called(2);
      },
    );

    test(
      'getCountries() should set countries to null if request is unsuccessful',
      () async {
        // Arrange
        when(
          () => mockCountriesService.getAll(),
        ).thenAnswer(
          (_) async => const CountriesResponse(
            countries: null,
            error: CountryResponseErrorType.notFound,
            isSuccess: false,
          ),
        );

        // Act
        controller = HomeController(mockCountriesService);
        await controller.getCountries();

        // Assert
        expect(controller.state.countries, isNull);
      },
    );

    test(
      'getCountries() should set countries to the returned list if request is successful',
      () async {
        // Arrange
        final countries = [
          const CountrySimplified(
            code: 'BRA',
            commonName: 'Brazil',
            officialName: 'Federative Republic of Brazil',
            flag: 'https://flagcdn.com/w320/br.png',
          ),
          const CountrySimplified(
            code: 'CAN',
            commonName: 'Canada',
            officialName: 'Canada',
            flag: 'https://flagcdn.com/w320/ca.png',
          ),
        ];

        when(
          () => mockCountriesService.getAll(),
        ).thenAnswer(
          (_) async => CountriesResponse(
            isSuccess: true,
            countries: countries,
            error: null,
          ),
        );

        // Act
        controller = HomeController(mockCountriesService);
        await controller.getCountries();

        // Assert
        expect(controller.state.countries, countries);
      },
    );
  });
}
