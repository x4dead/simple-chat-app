// import 'package:flutter/material.dart';
// import 'package:sfera_web/utils/constants/ui_constants.dart';

// class DialogPage<T> extends Page<T> {
//   final Offset? anchorPoint;
//   final Color? barrierColor;
//   final bool barrierDismissible;
//   final String? barrierLabel;
//   final bool useSafeArea;
//   final CapturedThemes? themes;
//   final WidgetBuilder builder;

//   const DialogPage({
//     required this.builder,
//     this.anchorPoint,
//     this.barrierColor = Colors.black54,
//     this.barrierDismissible = true,
//     this.barrierLabel,
//     this.useSafeArea = true,
//     this.themes,
//     super.key,
//     super.name,
//     super.arguments,
//     super.restorationId,
//   });

//   @override
//   Route<T> createRoute(BuildContext context) => DialogRoute<T>(
//         context: context,
//         settings: this,
//         builder: (context) => CustomDialog(child: builder(context)),
//         anchorPoint: anchorPoint,
//         barrierColor: barrierColor,
//         barrierDismissible: barrierDismissible,
//         barrierLabel: barrierLabel,
//         useSafeArea: useSafeArea,
//         themes: themes,
//       );
// }

// class CustomDialog extends StatelessWidget {
//   const CustomDialog({super.key, required this.child});
//   final Widget child;
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedPadding(
//       padding: defaultDialogInsetPadding,
//       duration: const Duration(milliseconds: 100),
//       curve: Curves.decelerate,
//       child: MediaQuery.removeViewInsets(
//         removeLeft: true,
//         removeTop: true,
//         removeRight: true,
//         removeBottom: true,
//         context: context,
//         child: Center(
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(minWidth: 280),
//             child: Material(
//               type: MaterialType.transparency,
//               child: child,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
