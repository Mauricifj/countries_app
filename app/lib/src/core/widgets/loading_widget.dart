import 'package:flutter/material.dart';

import '../style/spacings.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final TextStyle? style;
  final double size;

  const LoadingWidget({
    super.key,
    this.message,
    this.style,
    this.size = 48,
  })  : assert(size >= 0),
        assert(
          (message != null && style != null) ||
              (message == null && style == null),
        );

  @override
  Widget build(BuildContext context) {
    final message = this.message;

    if (message != null) {
      return Column(
        children: [
          _buildLoadingAnimation(),
          Spacings.medium.verticalSpacing,
          Text(
            message,
            style: style,
          ),
        ],
      );
    }

    return _buildLoadingAnimation();
  }

  Widget _buildLoadingAnimation() {
    return SizedBox(
      height: size,
      width: size,
      child: const CircularProgressIndicator(),
    );
  }
}
