part of '../chat_page.dart';

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
                onPressed: () {}, icon: SvgPicture.asset(AppImages.attach)),
          ),
          kSBW8,
          Expanded(
            child: HintTextField(
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
                } catch (e) {
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
                onPressed: () {}, icon: SvgPicture.asset(AppImages.audio)),
          ),
        ],
      ),
    );
  }
}
