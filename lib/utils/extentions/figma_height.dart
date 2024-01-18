extension FigmaDimention on double {
  double toFigmaHeight(double fontSize) {
    return this / fontSize;
  }
}

enum FigmaBreakpoint { mobile, tablet, small, medium, large }
