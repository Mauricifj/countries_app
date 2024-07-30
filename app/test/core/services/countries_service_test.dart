import 'dart:convert';

import 'package:countries_app/src/core/models/country/country_error_type.dart';
import 'package:countries_app/src/core/models/http/http_error.dart';
import 'package:countries_app/src/core/models/http/http_response.dart';
import 'package:countries_app/src/core/services/countries_service.dart';
import 'package:countries_app/src/core/services/http_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpService extends Mock implements HttpService {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('CountriesService', () {
    late CountriesService service;
    late MockHttpService mockHttpService;

    const countryCode = 'BRA';

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      mockHttpService = MockHttpService();
      service = CountriesServiceImpl(mockHttpService);
    });

    test(
      'getAll() should return countries list if request is successful',
      () async {
        // Arrange
        when(
          () => mockHttpService.get(
            any(),
          ),
        ).thenAnswer(
          (_) async => HttpResponse(
            isSuccessful: true,
            data: _mockCountriesJson,
            error: null,
          ),
        );

        // Act
        final result = await service.getAll();

        // Assert
        expect(result.isSuccess, true);
        expect(result.countries, isNotEmpty);
        expect(result.countries?.first.code, 'BRA');
        expect(result.error, null);
      },
    );

    test(
      'getAll() should not return countries list if request failed',
      () async {
        // Arrange
        when(
          () => mockHttpService.get(
            any(),
          ),
        ).thenAnswer(
          (_) async => HttpResponse(
            isSuccessful: false,
            data: null,
            error: HttpError(
              type: HttpErrorType.internalServerError,
              message: 'Server Error',
            ),
          ),
        );

        // Act
        final result = await service.getAll();

        // Assert
        expect(result.isSuccess, false);
        expect(result.countries, isNull);
        expect(result.error, isNotNull);
        expect(result.error, CountryResponseErrorType.serverError);
        expect(result.error?.message, 'Server Error');
      },
    );

    test(
      'getByCode() should return the country if request is successful',
      () async {
        // Arrange
        when(
          () => mockHttpService.get(
            any(),
          ),
        ).thenAnswer(
          (_) async => HttpResponse(
            isSuccessful: true,
            data: _mockCountryJson,
            error: null,
          ),
        );

        // Act
        final result = await service.getByCode(countryCode);

        // Assert
        expect(result.isSuccess, true);
        expect(result.country, isNotNull);
        expect(result.country?.code, 'BRA');
        expect(result.country?.commonName, 'Brazil');
        expect(result.error, null);
      },
    );

    test(
      'getByCode() should not return country if request failed',
      () async {
        // Arrange
        when(
          () => mockHttpService.get(
            any(),
          ),
        ).thenAnswer(
          (_) async => HttpResponse(
            isSuccessful: false,
            data: null,
            error: HttpError(
              type: HttpErrorType.internalServerError,
              message: 'Server Error',
            ),
          ),
        );

        // Act
        final result = await service.getAll();

        // Assert
        expect(result.isSuccess, false);
        expect(result.countries, isNull);
        expect(result.error, isNotNull);
        expect(result.error, CountryResponseErrorType.serverError);
        expect(result.error?.message, 'Server Error');
      },
    );

    test(
      'searchByCode() should return countries list if request is successful',
      () async {
        // Arrange
        when(
          () => mockHttpService.get(
            any(),
          ),
        ).thenAnswer(
          (_) async => HttpResponse(
            isSuccessful: true,
            data: _mockCountriesJson,
            error: null,
          ),
        );

        // Act
        final result = await service.searchByCode([countryCode]);

        // Assert
        expect(result.isSuccess, true);
        expect(result.countries, isNotEmpty);
        expect(result.countries?.first.code, 'BRA');
        expect(result.countries?.first.commonName, 'Brazil');
        expect(result.error, null);
      },
    );

    test(
      'searchByCode() should not return countries list if request failed',
      () async {
        // Arrange
        when(
          () => mockHttpService.get(
            any(),
          ),
        ).thenAnswer(
          (_) async => HttpResponse(
            isSuccessful: false,
            data: null,
            error: HttpError(
              type: HttpErrorType.internalServerError,
              message: 'Server Error',
            ),
          ),
        );

        // Act
        final result = await service.getAll();

        // Assert
        expect(result.isSuccess, false);
        expect(result.countries, isNull);
        expect(result.error, isNotNull);
        expect(result.error, CountryResponseErrorType.serverError);
        expect(result.error?.message, 'Server Error');
      },
    );
  });
}

final _mockCountriesJson = jsonDecode(_mockCountriesResponse);

const _mockCountriesResponse = '''
[
  {
    "flags": {
      "png": "https://flagcdn.com/w320/br.png",
      "svg": "https://flagcdn.com/br.svg",
      "alt": "The flag of Brazil has a green field with a large yellow rhombus in the center. Within the rhombus is a dark blue globe with twenty-seven small five-pointed white stars depicting a starry sky and a thin white convex horizontal band inscribed with the national motto 'Ordem e Progresso' across its center."
    },
    "name": {
      "common": "Brazil",
      "official": "Federative Republic of Brazil",
      "nativeName": {
        "por": {
          "official": "República Federativa do Brasil",
          "common": "Brasil"
        }
      }
    },
    "cca3": "BRA"
  },
  {
    "flags": {
      "png": "https://flagcdn.com/w320/ca.png",
      "svg": "https://flagcdn.com/ca.svg",
      "alt": "The flag of Canada is composed of a red vertical band on the hoist and fly sides and a central white square that is twice the width of the vertical bands. A large eleven-pointed red maple leaf is centered in the white square."
    },
    "name": {
      "common": "Canada",
      "official": "Canada",
      "nativeName": {
        "eng": {
          "official": "Canada",
          "common": "Canada"
        },
        "fra": {
          "official": "Canada",
          "common": "Canada"
        }
      }
    },
    "cca3": "CAN"
  }
]
''';

final _mockCountryJson = jsonDecode(_mockCountryResponse);

const _mockCountryResponse = '''
{
  "flags": {
    "png": "https://flagcdn.com/w320/br.png",
    "svg": "https://flagcdn.com/br.svg",
    "alt": "The flag of Brazil has a green field with a large yellow rhombus in the center. Within the rhombus is a dark blue globe with twenty-seven small five-pointed white stars depicting a starry sky and a thin white convex horizontal band inscribed with the national motto 'Ordem e Progresso' across its center."
  },
  "name": {
    "common": "Brazil",
    "official": "Federative Republic of Brazil",
    "nativeName": {
      "por": {
        "official": "República Federativa do Brasil",
        "common": "Brasil"
      }
    }
  },
  "cca3": "BRA",
  "currencies": {
    "BRL": {
      "name": "Brazilian real",
      "symbol": "R\$"
    }
  },
  "capital": [
    "Brasília"
  ],
  "languages": {
    "por": "Portuguese"
  },
  "borders": [
    "ARG",
    "BOL",
    "COL",
    "GUF",
    "GUY",
    "PRY",
    "PER",
    "SUR",
    "URY",
    "VEN"
  ],
  "maps": {
    "googleMaps": "https://goo.gl/maps/waCKk21HeeqFzkNC9",
    "openStreetMaps": "https://www.openstreetmap.org/relation/59470"
  },
  "continents": [
    "South America"
  ]
}
''';
