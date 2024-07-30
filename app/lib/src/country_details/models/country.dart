import 'package:flutter/foundation.dart';

class Country {
  final String code;
  final String officialName;
  final String commonName;
  final String flagUrl;
  final List<String> borders;
  final List<String> languages;
  final List<String> currencies;
  final String capital;
  final String googleMapsUrl;
  final List<String> continents;

  const Country({
    required this.code,
    required this.officialName,
    required this.commonName,
    required this.flagUrl,
    required this.borders,
    required this.languages,
    required this.currencies,
    required this.capital,
    required this.googleMapsUrl,
    required this.continents,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    final nameNode = json['name'];

    final languagesMap = json['languages'] as Map<String, dynamic>?;
    final languages = languagesMap?.values.toList();

    final borders = json['borders'] as List<dynamic>?;

    final continents = json['continents'] as List<dynamic>?;

    final currenciesMap = json['currencies'] as Map<String, dynamic>?;
    final currenciesMap2 = currenciesMap?.values.toList();
    final currencies = currenciesMap2
        ?.map(
          (e) => '${e['name']} (${e['symbol']})',
        )
        .toList();

    return Country(
      code: json['cca3'],
      officialName: nameNode['official'],
      commonName: nameNode['common'],
      flagUrl: json['flags']?['png'],
      borders: borders != null ? List<String>.from(borders) : [],
      languages: languages != null ? List<String>.from(languages) : [],
      currencies: currencies ?? [],
      capital: json['capital']?[0],
      googleMapsUrl: json['maps']?['googleMaps'],
      continents: continents != null ? List<String>.from(continents) : [],
    );
  }

  Country copyWith({
    String? code,
    String? officialName,
    String? commonName,
    String? flagUrl,
    List<String>? borders,
    List<String>? languages,
    List<String>? currencies,
    String? capital,
    String? googleMapsUrl,
    List<String>? continents,
  }) {
    return Country(
      code: code ?? this.code,
      officialName: officialName ?? this.officialName,
      commonName: commonName ?? this.commonName,
      flagUrl: flagUrl ?? this.flagUrl,
      borders: borders ?? this.borders,
      languages: languages ?? this.languages,
      currencies: currencies ?? this.currencies,
      capital: capital ?? this.capital,
      googleMapsUrl: googleMapsUrl ?? this.googleMapsUrl,
      continents: continents ?? this.continents,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Country &&
        other.code == code &&
        other.officialName == officialName &&
        other.commonName == commonName &&
        other.flagUrl == flagUrl &&
        listEquals(other.borders, borders) &&
        listEquals(other.languages, languages) &&
        listEquals(other.currencies, currencies) &&
        other.capital == capital &&
        other.googleMapsUrl == googleMapsUrl &&
        listEquals(other.continents, continents);
  }

  @override
  int get hashCode {
    return code.hashCode ^
        officialName.hashCode ^
        commonName.hashCode ^
        flagUrl.hashCode ^
        borders.hashCode ^
        languages.hashCode ^
        currencies.hashCode ^
        capital.hashCode ^
        googleMapsUrl.hashCode ^
        continents.hashCode;
  }
}
