import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../authentication/controllers/auth_controller.dart';
import '../config/app_router.dart';
import '../core/style/spacings.dart';
import '../core/widgets/loading_widget.dart';
import 'controllers/home_controller.dart';
import 'widgets/countries_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries App'),
        actions: [
          IconButton(
            onPressed: () async {
              final scaffoldMessenger = ScaffoldMessenger.of(context);
              scaffoldMessenger.clearSnackBars();
              scaffoldMessenger.showSnackBar(
                SnackBar(
                  showCloseIcon: true,
                  backgroundColor: Theme.of(context).colorScheme.error,
                  content: const Text('Search is not available yet'),
                ),
              );
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

              Navigator.pushReplacementNamed(context, AppRouter.login);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final state = context.watch<HomeController>().state;

    if (state.isLoading) {
      return const Center(child: LoadingWidget());
    }

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final error = state.error;
    if (error != null) {
      final message = error.message;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            message,
            style: textTheme.titleLarge?.copyWith(color: colorScheme.error),
            textAlign: TextAlign.center,
          ),
          Spacings.medium.verticalSpacing,
          _buildRetryButton(context),
        ],
      );
    }

    final countries = state.countries;

    if (countries != null && countries.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'No countries found',
            style: textTheme.titleLarge?.copyWith(color: colorScheme.error),
            textAlign: TextAlign.center,
          ),
          Spacings.medium.verticalSpacing,
          _buildRetryButton(context),
        ],
      );
    }

    if (countries == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'No data available',
            style: textTheme.titleLarge?.copyWith(color: colorScheme.error),
            textAlign: TextAlign.center,
          ),
          Spacings.medium.verticalSpacing,
          _buildRetryButton(context),
        ],
      );
    }

    return CountriesList(countries: countries);
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
