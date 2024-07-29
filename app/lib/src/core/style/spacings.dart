import 'package:flutter/material.dart';

enum Spacings {
  none,
  xxxs,
  xxs,
  xs,
  small,
  medium,
  large,
  xl,
  xxl,
  xxxl;

  double get value {
    switch (this) {
      case Spacings.none:
        return 0;
      case Spacings.xxxs:
        return 2;
      case Spacings.xxs:
        return 4;
      case Spacings.xs:
        return 6;
      case Spacings.small:
        return 8;
      case Spacings.medium:
        return 16;
      case Spacings.large:
        return 24;
      case Spacings.xl:
        return 32;
      case Spacings.xxl:
        return 64;
      case Spacings.xxxl:
        return 128;
      default:
        return 0;
    }
  }

  EdgeInsets get padding {
    return EdgeInsets.all(value);
  }

  EdgeInsets get horizontalPadding {
    return EdgeInsets.symmetric(horizontal: value);
  }

  EdgeInsets get verticalPadding {
    return EdgeInsets.symmetric(vertical: value);
  }

  Widget spacing({bool vertical = false, bool horizontal = false}) {
    return SizedBox(
      height: vertical ? value : 0,
      width: horizontal ? value : 0,
    );
  }

  Widget get verticalSpacing {
    return spacing(vertical: true);
  }

  Widget get horizontalSpacing {
    return spacing(horizontal: true);
  }
}
