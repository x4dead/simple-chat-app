import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_chat_app/models/src/chat_dto.dart';
import 'package:simple_chat_app/models/src/message_dto.dart';
import 'package:simple_chat_app/modules/signal_service/river/river.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';
import 'package:simple_chat_app/utils/constants/ui_constants.dart';
import 'package:simple_chat_app/utils/extentions/converting.dart';
import 'package:simple_chat_app/utils/extentions/media_query.dart';
import 'package:simple_chat_app/utils/resources/app_images.dart';
import 'package:simple_chat_app/utils/user_pref.dart';
import 'package:simple_chat_app/widgets/hint_text_field.dart';
import 'package:simple_chat_app/widgets/custom_list_tile.dart';

part 'widgets/chat_date_time_widget.dart';
part 'widgets/chat_header.dart';
part 'widgets/chat_input_widget.dart';
part 'widgets/message_bubble_widget.dart';
part 'widgets/message_tail_clipper.dart';
part 'widgets/messages_list_widget.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            ChatHeader(),
            Divider(color: AppColors.colorStroke, height: 1),
            MessagesListWidget(),
            Divider(color: AppColors.colorStroke, height: 1),
            ChatInputWidget()
          ],
        ),
      ),
    );
  }
}
