import 'dart:convert';

import 'package:countries_app/src/core/models/http_error.dart';
import 'package:countries_app/src/core/models/http_response.dart';
import 'package:countries_app/src/core/services/http_service.dart';
import 'package:countries_app/src/home/models/countries_response.dart';
import 'package:countries_app/src/home/services/countries_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpService extends Mock implements HttpService {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('CountriesService', () {
    late CountriesService service;
    late MockHttpService mockHttpService;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      mockHttpService = MockHttpService();
      service = CountriesServiceImpl(mockHttpService);
    });

    test(
      'get() should return countries list if request is successful',
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
      'get() should not return countries list if request is successful',
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
        expect(result.error, CountriesErrorType.serverError);
        expect(result.error?.message, 'Server Error');
      },
    );
  });
}

final _mockCountriesJson = jsonDecode(_mockCountriesResponse);

const _mockCountriesResponse = '''
[
  {
    "name": {
      "common": "Brazil",
      "official": "Federative Republic of Brazil"
    },
    "cca3": "BRA",
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
    "flag": "🇧🇷",
    "flags": {
      "png": "https://flagcdn.com/w320/br.png"
    }
  }
]
''';
