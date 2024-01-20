
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat_app/utils/constants/ui_constants.dart';


class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.contentPadding,
    this.leadingUrl,
    required this.title,
    this.subTitle,
    this.overline,
    this.color,
    this.trailingImgUrl,
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
  });
  final EdgeInsetsGeometry? contentPadding;
  final String? leadingUrl;
  final Widget? leading;
  final String? trailingImgUrl;
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
  final BorderRadiusGeometry? borderRadius;
  final Function()? onTap;
  final double? radius;
  final List<BoxShadow>? boxShadow;
  final Clip clipBehavior;
  @override
  Widget build(BuildContext context) {
    // final lenta = context.customTheme.overlayLenta;
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
                      if (leadingUrl != null && leading == null)
                        _NotificationImage(
                          imageUrl: leadingUrl!,
                          height: leadingHeight ?? 40,
                          width: leadingWidth ?? 40,
                        ),
                      if (leading != null && leadingUrl == null) leading!,
                      if (isLeadingTop == true) const Spacer()
                    ],
                  ),

                  SizedBox(width: horizontalTitleGap),

                  ///
                  ///CONTENT
                  ///
                  Expanded(
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: titleStyle ?? TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: topSubTitleGap),
                        if (subTitle != null && subTitleWidget == null)
                          Text(
                            subTitle!,
                            overflow: TextOverflow.ellipsis,
                            style: subTitleStyle ?? TextStyle(),
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
                                TextStyle(
                                    fontSize: 12,
                                    // color: lenta?.colorOnSurfaceVariant,
                                    fontWeight: FontWeight.w500),
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
                      if (trailingImgUrl != null && trailing == null)
                        _NotificationImage(
                            imageUrl: trailingImgUrl!,
                            height: 56,
                            width: 56,
                            radius: 8),
                      if (trailing != null && trailingImgUrl == null) trailing!,
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

class _NotificationImage extends StatelessWidget {
  const _NotificationImage({
    super.key,
    required this.imageUrl,
    this.width = 40,
    this.height = 40,
    this.radius = 100,
  });
  final double? width;
  final double? height;
  final double? radius;

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    // final lenta = context.customTheme.overlayLenta;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        shape: BoxShape.rectangle,
        // image: DecorationImage(image: imageProvider)
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,

        // borderRadius: BorderRadius.circular(radius!),
        // shape: BoxShape.rectangle,
        // clipBehavior: Clip.hardEdge,

        progressIndicatorBuilder: (context, url, progress) => ColoredBox(
          color: Colors.yellow,
          child: Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                // color: AppColors.color5B6975,
                value: progress.progress,
              ),
            ),
          ),
        ),
        errorWidget: (context, url, error) => kNothing,
        // imageBuilder: (context, imageProvider) =>
        // Image.asset(AppImages.errorImage),

        // ColoredBox(
        //   color: AppColors.color152A3A,
        //   child: Center(
        //     child: SizedBox(
        //       width: 24,
        //       height: 24,
        //       child: CircularProgressIndicator(
        //         strokeWidth: 2,
        //         color: AppColors.color5B6975,
        //         // value: progress.progress,
        //       ),
        //     ),
        //   ),
        // ),
        // Container(
        //   clipBehavior: Clip.hardEdge,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(radius!),
        //       shape: BoxShape.rectangle,
        //       image: DecorationImage(image: imageProvider)),
        // ),
        // else if (state.extendedImageLoadState == LoadState.failed) {
        //       return Padding(
        //         padding: const EdgeInsets.all(4.0),
        //         child: Image.asset(AppImages.errorImage),
        //       );
        //     } else {
        // return state.completedWidget;
        // }
        // },
        // imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
