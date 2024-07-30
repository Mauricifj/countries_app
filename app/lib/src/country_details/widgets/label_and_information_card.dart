import 'package:flutter/material.dart';

import '../../core/style/spacings.dart';

class LabelAndInformationCard extends StatelessWidget {
  final String label;
  final String information;

  const LabelAndInformationCard({
    super.key,
    required this.label,
    required this.information,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Card(
        color: colorScheme.primaryContainer,
        margin: Spacings.medium.margin,
        child: Padding(
          padding: Spacings.medium.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                label,
                style: textTheme.titleLarge?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                information,
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
