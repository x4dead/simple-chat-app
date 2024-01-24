import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_chat_app/models/src/chat_dto.dart';
import 'package:simple_chat_app/modules/signal_service/river/river.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';
import 'package:simple_chat_app/utils/constants/ui_constants.dart';
import 'package:simple_chat_app/utils/extentions/figma_height.dart';
import 'package:simple_chat_app/utils/resources/app_images.dart';
import 'package:simple_chat_app/utils/user_pref.dart';
import 'package:simple_chat_app/widgets/app_text_field.dart';

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
    final chatNotifier = ref.read(River.chatsPod.notifier);
    return Padding(
      padding: kPL20R20B44T14,
      child: Row(
        children: [
          SizedBox(
            height: 42,
            width: 42,
            child: IconButton(
                onPressed: () {
                  ///TODO
                },
                icon: SvgPicture.asset(AppImages.attach)),
          ),
          kSBW8,
          Expanded(
            child: AppTextField(
              hintText: 'Сообщение',
              controller: textController,
              onFieldSubmitted: (value) async {
                try {
                  final selectedChatUid =
                      ref.watch(River.chatsPod).selectedChat!.uid!;
                  if (textController.text.isNotEmpty) {
                    final myAcc =
                        await ref.read(River.usersPod.notifier).getUserByUid();

                    ///Проверка на наличие чата у второго пользователя с первым
                    await chatNotifier.createChat(
                        mainUserId: selectedChatUid,
                        receiverChat: ChatDto(
                          firstName: myAcc.firstName,
                          isOnline: myAcc.isOnline,
                          lastActive: myAcc.lastActive,
                          lastName: myAcc.lastName,
                          uid: myAcc.uid,
                        ));
                    await ref.read(River.messagesPod.notifier).sendMessage(
                        content: value, receiverId: selectedChatUid);
                    textController.clear();
                    final lastMessageInChat =
                        ref.watch(River.messagesPod).messages?.last;

                    await chatNotifier.updateChatData({
                      "last_message": lastMessageInChat?.content,
                      "last_message_date":
                          lastMessageInChat?.sentTime?.toIso8601String(),
                      "message_receiver_id": lastMessageInChat?.receiverId,
                    },
                        mainUid: UserPref.getUserUid,
                        updatedChatUid: selectedChatUid);
                    await chatNotifier.updateChatData({
                      "last_message": lastMessageInChat?.content,
                      "last_message_date":
                          lastMessageInChat?.sentTime?.toIso8601String(),
                      "message_receiver_id": lastMessageInChat?.receiverId,
                    },
                        mainUid: selectedChatUid,
                        updatedChatUid: UserPref.getUserUid);
                  }
                } catch (e) {}
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 11.5),
              constraints: const BoxConstraints(maxHeight: 42),
            ),
          ),
          kSBW8,
          SizedBox(
            height: 42,
            width: 42,
            child: IconButton(
                onPressed: () {
                  ///TODO
                },
                icon: SvgPicture.asset(AppImages.audio)),
          ),
        ],
      ),
    );
  }
}
