import 'package:flutter/material.dart';

import '../../core/style/spacings.dart';
import '../models/country_simplified.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({
    super.key,
    required this.country,
  });

  final CountrySimplified country;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Spacings.symmetricMargin(Spacings.medium, Spacings.small),
      child: ListTile(
        title: Text(country.commonName),
        subtitle: Text(country.officialName),
        leading: Image.network(
          country.flag,
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
