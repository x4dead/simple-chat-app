import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_chat_app/pages/chat_list_page/widgets/list_users_widget.dart';
import 'package:simple_chat_app/pages/chat_page/widgets/chat_header.dart';
import 'package:simple_chat_app/pages/chat_page/widgets/chat_input_widget.dart';
import 'package:simple_chat_app/pages/chat_page/widgets/messages_list_widget.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';
import 'package:simple_chat_app/utils/constants/ui_constants.dart';
import 'package:simple_chat_app/utils/extentions/converting.dart';
import 'package:simple_chat_app/utils/resources/app_images.dart';
import 'package:simple_chat_app/widgets/custom_list_tile.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Column(
        children: [
          ChatHeader(),
          Divider(color: AppColors.colorStroke, height: 1),

          ///CHAT
          MessagesListWidget(),
          Divider(color: AppColors.colorStroke, height: 1),
          ChatInputWidget()
        ],
      ),
    );
  }
}
