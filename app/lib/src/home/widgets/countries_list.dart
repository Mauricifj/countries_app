import 'package:flutter/material.dart';

import '../models/country_simplified.dart';
import 'country_card.dart';

class CountriesList extends StatelessWidget {
  final List<CountrySimplified> countries;

  const CountriesList({
    super.key,
    required this.countries,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context, index) {
        final country = countries[index];
        return CountryCard(country: country);
      },
    );
  }
}
