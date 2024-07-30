import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
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
      onPressed: onPressed,
      child: Text(
        text,
        style: textTheme.titleLarge?.copyWith(
          color: colorScheme.onErrorContainer,
        ),
      ),
    );
  }
}
