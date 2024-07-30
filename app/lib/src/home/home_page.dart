import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../authentication/controllers/auth_controller.dart';
import '../config/app_router.dart';
import '../core/style/spacings.dart';
import '../core/widgets/loading_widget.dart';
import 'controllers/home_controller.dart';
import 'controllers/states/home_state.dart';
import 'models/country_simplified.dart';
import 'widgets/countries_list.dart';
import 'widgets/countries_search_delegate.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final maxWidth = const BoxConstraints(maxWidth: 600);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries App'),
        actions: [
          IconButton(
            onPressed: () async {
              final countries = context.read<HomeController>().state.countries;
              final result = await showSearch(
                context: context,
                delegate: CountriesSearchDelegate(countries: countries ?? []),
              );
              if (context.mounted && result != null) {
                context.goNamed(
                  AppRouter.detailsName,
                  pathParameters: {'code': result.code},
                );
              }
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () async {
              final controller = context.read<AuthController>();
              await controller.logout();

              if (!context.mounted) {
                return;
              }

              context.goNamed(AppRouter.loginName);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        if (controller.state.isLoading) {
          return const Center(
            child: LoadingWidget(),
          );
        }

        final error = controller.state.error;
        if (error != null) {
          return _buildError(context, error);
        }

        return _buildDetails(context, controller.state.countries);
      },
    );
  }

  Widget _buildDetails(
    BuildContext context,
    List<CountrySimplified>? countries,
  ) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    if (countries != null && countries.isEmpty) {
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
                  'No countries found',
                  style:
                      textTheme.titleLarge?.copyWith(color: colorScheme.error),
                  textAlign: TextAlign.center,
                ),
                Spacings.medium.verticalSpacing,
                _buildRetryButton(context),
              ],
            ),
          ),
        ),
      );
    }

    if (countries == null) {
      return Center(
        child: Padding(
          padding: Spacings.medium.horizontalPadding,
          child: ConstrainedBox(
            constraints: maxWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'No data available',
                  style:
                      textTheme.titleLarge?.copyWith(color: colorScheme.error),
                  textAlign: TextAlign.center,
                ),
                Spacings.medium.verticalSpacing,
                _buildRetryButton(context),
              ],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(child: CountriesList(countries: countries));
  }

  Widget _buildError(BuildContext context, HomeErrorType error) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

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
              _buildRetryButton(context),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _buildRetryButton(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(
          const Size(600, 50),
        ),
        backgroundColor: WidgetStateProperty.all(
          colorScheme.errorContainer,
        ),
      ),
      onPressed: () {
        context.read<HomeController>().getCountries();
      },
      child: Text(
        'Retry',
        style: textTheme.titleLarge?.copyWith(
          color: colorScheme.onErrorContainer,
        ),
      ),
    );
  }
}
