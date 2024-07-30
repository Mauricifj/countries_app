import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/style/spacings.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/loading_widget.dart';
import 'controllers/country_details_controller.dart';
import 'controllers/states/details_state.dart';
import 'models/country.dart';
import 'widgets/label_and_information_card.dart';

class CountryDetailsPage extends StatefulWidget {
  final String countryCode;

  const CountryDetailsPage({
    super.key,
    required this.countryCode,
  });

  @override
  State<CountryDetailsPage> createState() => _CountryDetailsPageState();
}

class _CountryDetailsPageState extends State<CountryDetailsPage> {
  ThemeData get theme => Theme.of(context);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  final maxWidth = const BoxConstraints(maxWidth: 600);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData();
  }

  void loadData() {
    context.read<CountryDetailsController>().getByCode(widget.countryCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Details'),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Consumer<CountryDetailsController>(
      builder: (context, controller, child) {
        if (controller.state.isLoading) {
          return const Center(
            child: LoadingWidget(),
          );
        }

        final error = controller.state.error;
        if (error != null) {
          return _buildError(error);
        }

        return _buildDetails(controller.state.country);
      },
    );
  }

  Widget _buildError(CountryErrorType error) {
    return Center(
      child: ConstrainedBox(
        constraints: maxWidth,
        child: Padding(
          padding: Spacings.medium.horizontalPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                error.message,
                style: textTheme.titleLarge?.copyWith(color: colorScheme.error),
                textAlign: TextAlign.center,
              ),
              Spacings.medium.verticalSpacing,
              CustomButton(text: 'Retry', onPressed: loadData),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(Country? country) {
    if (country == null) {
      return Center(
        child: ConstrainedBox(
          constraints: maxWidth,
          child: Padding(
            padding: Spacings.medium.horizontalPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'No data',
                  style:
                      textTheme.titleLarge?.copyWith(color: colorScheme.error),
                  textAlign: TextAlign.center,
                ),
                Spacings.medium.verticalSpacing,
                CustomButton(text: 'Retry', onPressed: loadData),
              ],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: country.flagUrl,
              width: 300,
              height: 300,
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
            Spacings.small.verticalSpacing,
            LabelAndInformationCard(
              label: 'Common Name',
              information: country.commonName,
            ),
            LabelAndInformationCard(
              label: 'Official Name',
              information: country.officialName,
            ),
            LabelAndInformationCard(
              label: 'Capital',
              information: country.capital,
            ),
            LabelAndInformationCard(
              label: 'Languages',
              information: country.languages.join(', '),
            ),
            LabelAndInformationCard(
              label: 'Currencies',
              information: country.currencies.join(', '),
            ),
            LabelAndInformationCard(
              label: 'Continents',
              information: country.continents.join(', '),
            ),
            LabelAndInformationCard(
              label: 'Borders',
              information: country.borders.join(', '),
            ),
            InkWell(
              onTap: () {
                launchUrl(Uri.parse(country.googleMapsUrl));
              },
              child: LabelAndInformationCard(
                label: 'Click here to view on Google Maps',
                information: country.googleMapsUrl,
              ),
            ),
            Spacings.large.verticalSpacing,
          ],
        ),
      ),
    );
  }
}
