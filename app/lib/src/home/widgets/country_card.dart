import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/app_router.dart';
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
    return InkWell(
      onTap: () {
        context.goNamed(
          AppRouter.detailsName,
          pathParameters: {'code': country.code},
        );
      },
      child: Card(
        margin: Spacings.symmetricMargin(Spacings.medium, Spacings.small),
        child: ListTile(
          title: Text(country.commonName),
          subtitle: Text(country.officialName),
          leading: CachedNetworkImage(
            imageUrl: country.flag,
            width: 50,
            height: 50,
            progressIndicatorBuilder: (context, url, progress) {
              return Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              );
            },
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
