﻿import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_chat_app/modules/signal_service/river/river.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';
import 'package:simple_chat_app/utils/constants/ui_constants.dart';
import 'package:simple_chat_app/utils/extentions/figma_height.dart';
import 'package:simple_chat_app/utils/resources/app_images.dart';

class ChatListHeader extends ConsumerStatefulWidget {
  const ChatListHeader({
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

class _ChatListHeaderState extends ConsumerState<ChatListHeader> {
  // final FocusNode focusNode = FocusNode();
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
                      padding: EdgeInsets.zero,
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
                      onPressed: () async => await ref
                          .read(River.authPod.notifier)
                          .signOut(context),
                      icon: const Icon(
                        CupertinoIcons.square_arrow_right,
                      )),
                )
              ]
            ],
          ),
          kSBH6,
          TextField(
            controller: textController,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 19.0.toFigmaHeight(16.0),
            ),
            cursorColor: AppColors.colorDarkGray,
            decoration: InputDecoration(
              isDense: true,
              fillColor: AppColors.colorStroke,
              filled: true,
              prefixIconConstraints:
                  const BoxConstraints(maxHeight: 24, maxWidth: 38),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 8, right: 6),
                child: SvgPicture.asset(AppImages.search),
              ),
              hintText: 'Поиск',
              border: InputBorder.none,
              hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 19.0.toFigmaHeight(16.0),
                  color: AppColors.colorGray),
              constraints: const BoxConstraints(maxHeight: 42),
            ),
          ),
        ],
      ),
    );
  }
}
