﻿import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';
import 'package:simple_chat_app/utils/constants/ui_constants.dart';
import 'package:simple_chat_app/utils/extentions/figma_height.dart';
import 'package:simple_chat_app/utils/resources/app_images.dart';

class ChatListHeader extends ConsumerStatefulWidget {
  const ChatListHeader({super.key});

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
          Text(
            'Чаты',
            style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                height: 39.0.toFigmaHeight(32.0),
                color: AppColors.colorBlack),
          ),
          kSBH6,
          TextField(
            controller: textController,
    
            onChanged: (text) {},
            // onSubmitted: (value) {
            //   focusNode.unfocus();
            // },

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
