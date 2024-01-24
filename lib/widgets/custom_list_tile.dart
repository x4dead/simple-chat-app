import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.contentPadding,
    required this.title,
    this.subTitle,
    this.overline,
    this.color,
    this.trailing,
    this.height,
    this.horizontalTitleGap = 8,
    this.titleStyle,
    this.subTitleStyle,
    this.overlineWidget,
    this.overlineStyle,
    this.leadingHeight,
    this.leadingWidth,
    this.topOverlineGap = 4,
    this.topLeadingGap = 0,
    this.subTitleMaxLines,
    this.horizontalTrailingGap = 8,
    this.topSubTitleGap = 0,
    this.leading,
    this.isLeadingTop = true,
    this.isTrailingTop = true,
    this.borderRadius,
    this.onTap,
    this.radius,
    this.boxShadow,
    this.clipBehavior = Clip.none,
    this.bottomOverlineGap = 0,
    this.subTitleWidget,
    this.titleMaxLines,
  });
  final EdgeInsetsGeometry? contentPadding;

  final Widget? leading;

  final Widget? trailing;
  final String title;
  final String? subTitle;
  final String? overline;
  final Widget? overlineWidget;
  final Widget? subTitleWidget;
  final Color? color;
  final bool? isTrailingTop;
  final bool? isLeadingTop;

  final double? height;
  final TextStyle? titleStyle;
  final TextStyle? overlineStyle;
  final TextStyle? subTitleStyle;
  final double? horizontalTitleGap;
  final double? horizontalTrailingGap;
  final double? topLeadingGap;

  final double? topOverlineGap;
  final double? topSubTitleGap;
  final double? bottomOverlineGap;
  final double? leadingHeight;
  final double? leadingWidth;
  final int? subTitleMaxLines;
  final int? titleMaxLines;
  final BorderRadiusGeometry? borderRadius;
  final Function()? onTap;
  final double? radius;
  final List<BoxShadow>? boxShadow;
  final Clip clipBehavior;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.zero,
          color: color,
          boxShadow: boxShadow),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius ?? 0),
          child: SizedBox(
            height: height,
            child: Padding(
              padding: contentPadding ?? const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ///
                  ///LEADING
                  ///
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: topLeadingGap),
                      if (leading != null) leading!,
                      if (isLeadingTop == true) const Spacer()
                    ],
                  ),

                  SizedBox(width: horizontalTitleGap),

                  ///
                  ///CONTENT
                  ///
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          maxLines: titleMaxLines,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: titleStyle ?? const TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: topSubTitleGap),
                        if (subTitle != null && subTitleWidget == null)
                          Text(
                            subTitle!,
                            overflow: TextOverflow.ellipsis,
                            style: subTitleStyle ?? const TextStyle(),
                            maxLines: subTitleMaxLines,
                          ),
                        if (subTitleWidget != null && subTitle == null)
                          subTitleWidget!,
                        SizedBox(height: topOverlineGap),
                        if (overline != null && overlineWidget == null)
                          Text(
                            overline!,
                            overflow: TextOverflow.ellipsis,
                            style: overlineStyle ??
                                const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        if (overlineWidget != null && overline == null)
                          overlineWidget!,
                        SizedBox(height: bottomOverlineGap),
                      ],
                    ),
                  ),
                  SizedBox(width: horizontalTrailingGap),

                  ///
                  ///TRAILING
                  ///
                  Column(
                    mainAxisAlignment: isTrailingTop == true
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      if (trailing != null) trailing!,
                      if (isTrailingTop == true) const Spacer()
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
