import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';
import 'package:simple_chat_app/utils/constants/ui_constants.dart';
import 'package:simple_chat_app/utils/extentions/figma_height.dart';
import 'package:simple_chat_app/utils/resources/app_images.dart';

class ChatInputWidget extends ConsumerStatefulWidget {
  const ChatInputWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChatInputWidgetState();
}

class _ChatInputWidgetState extends ConsumerState<ChatInputWidget> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPL20R20B44T14,
      child: TextField(
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
          // isDense: true,
          fillColor: AppColors.colorStroke,
          filled: true,
          prefixIconConstraints:
              const BoxConstraints(maxHeight: 42, maxWidth: 62),

          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
                  ///TODO
                },
                icon: SvgPicture.asset(AppImages.attach)),
          ),
          suffixIconConstraints:
              const BoxConstraints(maxHeight: 42, maxWidth: 50),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: IconButton(
                onPressed: () {
                  ///TODO
                },
                icon: SvgPicture.asset(AppImages.audio)),
          ),
          constraints: const BoxConstraints(maxHeight: 42),
          hintText: 'Сообщение',
          border: InputBorder.none,

          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 19.0.toFigmaHeight(16.0),
              color: AppColors.colorGray),
        ),
      ),
    );
  }
}
