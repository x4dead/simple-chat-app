import 'package:flutter/widgets.dart';

extension MediaQueryExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;
}

extension AdaptiveExtension on num {
  double setAdaptiveSize(BuildContext context) {
    final height = context.height;
    final width = context.width;
    return width < height ? setWidth(context) : setHeight(context);
  }

  double setText(BuildContext context) {
    return (setHeight(context) + setWidth(context)) / 2;
  }

  double setHeight(BuildContext context) => (context.height / 1080) * this;
  double setWidth(BuildContext context) => (context.width / 1920) * this;
}
