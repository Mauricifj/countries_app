import 'package:flutter/material.dart';

import '../models/country_simplified.dart';

class CountriesSearchDelegate extends SearchDelegate<CountrySimplified?> {
  final List<CountrySimplified> countries;

  CountriesSearchDelegate({
    required this.countries,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = search(query);
    return _buildCountryList(context, results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = search(query);
    return _buildCountryList(context, results);
  }

  Widget _buildCountryList(
    BuildContext context,
    List<CountrySimplified> countries,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: countries.length,
      itemBuilder: (context, index) {
        final country = countries[index];
        return _buildCountryTile(context, country);
      },
    );
  }

  Widget _buildCountryTile(BuildContext context, CountrySimplified country) {
    return ListTile(
      title: Text(country.commonName),
      subtitle: Text(country.officialName),
      onTap: () {
        close(context, country);
      },
    );
  }

  List<CountrySimplified> search(String query) {
    final queryLowCase = query.toLowerCase();

    return countries
        .where(
          (country) =>
              country.officialName.toLowerCase().contains(queryLowCase) ||
              country.commonName.toLowerCase().contains(queryLowCase),
        )
        .toList();
  }
}
