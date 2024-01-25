import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_chat_app/modules/signal_service/river/river.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';
import 'package:simple_chat_app/utils/constants/ui_constants.dart';
import 'package:simple_chat_app/utils/extentions/figma_height.dart';
import 'package:simple_chat_app/utils/resources/app_images.dart';
import 'package:simple_chat_app/widgets/hint_text_field.dart';

class CustomChatHeader extends ConsumerStatefulWidget {
  const CustomChatHeader({
    this.titleStyle,
    this.isGoBackButton = false,
    this.isSignOutButton = true,
    super.key,
    this.title = 'Чаты',
    this.onChanged,
    this.onSubmitted,
  });
  final String? title;
  final TextStyle? titleStyle;
  final Function(String value)? onChanged;
  final Function(String value)? onSubmitted;
  final bool? isSignOutButton;
  final bool? isGoBackButton;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListHeaderState();
}

class _ChatListHeaderState extends ConsumerState<CustomChatHeader> {
  BuildContext? loadingCtx;
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      width: double.maxFinite,
      padding: kPL20R20B14T24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (widget.isGoBackButton == true) ...[
                SizedBox(
                  height: 36,
                  width: 36,
                  child: IconButton(
                      padding: kPZero,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: SvgPicture.asset(AppImages.arrowLeft)),
                ),
                kSBW6,
              ],
              Text(
                widget.title!,
                style: widget.titleStyle ??
                    TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        height: 39.0.toFigmaHeight(32.0),
                        color: AppColors.colorBlack),
              ),
              if (widget.isSignOutButton == true) ...[
                const Spacer(),
                SizedBox(
                  height: 39,
                  width: 39,
                  child: IconButton(
                      onPressed: () async {
                        try {
                          showCupertinoDialog(
                            context: context,
                            builder: (loadingContext) {
                              loadingCtx = loadingContext;
                              return const CupertinoActivityIndicator();
                            },
                          );
                          await ref
                              .read(River.usersPod.notifier)
                              .updateUserData({
                            "last_active": DateTime.now().toIso8601String(),
                            "is_online": false,
                          });
                          if (context.mounted) {
                            await ref
                                .read(River.authPod.notifier)
                                .signOut(context);
                          }
                          if (loadingCtx != null) {
                            Navigator.of(loadingCtx!).pop();
                          }
                        } catch (e) {
                          if (loadingCtx != null) {
                            Navigator.of(loadingCtx!).pop();
                          }
                          if (mounted) {
                            showDialog(
                                context: context,
                                builder: (ctx) => CupertinoAlertDialog(
                                      title: const Text("Error"),
                                      content: Text(e.toString()),
                                    ));
                          }
                        }
                      },
                      icon: const Icon(
                        CupertinoIcons.square_arrow_right,
                      )),
                )
              ]
            ],
          ),
          kSBH6,
          HintTextField(
            hintText: 'Поиск',
            isDense: true,
            controller: textController,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            constraints: const BoxConstraints(maxHeight: 42),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 11.5, horizontal: 8),
            prefixConstraints:
                const BoxConstraints(maxHeight: 24, maxWidth: 38),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 8, right: 6),
              child: SvgPicture.asset(AppImages.search),
            ),
          ),
        ],
      ),
    );
  }
}
