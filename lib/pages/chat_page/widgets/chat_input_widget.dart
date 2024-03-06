part of '../chat_page.dart';

class ChatInputWidget extends ConsumerStatefulWidget {
  const ChatInputWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChatInputWidgetState();
}

class _ChatInputWidgetState extends ConsumerState<ChatInputWidget> {
  final TextEditingController textController = TextEditingController();
  ValueNotifier<bool?> isMessageEmpty = ValueNotifier(true);

  StateProvider<bool?> isSending = StateProvider((ref) => false);

  @override
  Widget build(BuildContext context) {
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
              enabled: ref.watch(isSending) == true ? false : true,
              onChanged: (text) {
                if (text.isEmpty) {
                  isMessageEmpty.value = true;
                } else {
                  isMessageEmpty.value = false;
                }
              },
              hintText: 'Сообщение',
              controller: textController,
              onFieldSubmitted: ref.watch(isSending) == true
                  ? null
                  : (value) => sendMessage(),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 11.5),
              constraints: const BoxConstraints(maxHeight: 42),
            ),
          ),
          kSBW8,
          SizedBox(
            height: 42,
            width: 42,
            child: ref.watch(isSending) == true
                ? const Center(
                    child: CupertinoActivityIndicator(radius: 9),
                  )
                : IconButton(
                    onPressed: () {
                      if (isMessageEmpty.value == true) {
                      } else {
                        sendMessage();
                      }
                    },
                    icon: ValueListenableBuilder(
                        valueListenable: isMessageEmpty,
                        builder: (context, v, c) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: isMessageEmpty.value == false
                                ? SvgPicture.asset(
                                    AppImages.sendMessage,
                                    width: 21,
                                    height: 21,
                                    colorFilter: const ColorFilter.mode(
                                        AppColors.colorBlack, BlendMode.srcIn),
                                    key: const ValueKey('send'),
                                  )
                                : SvgPicture.asset(
                                    AppImages.audio,
                                    key: const ValueKey('audio'),
                                  ),
                            transitionBuilder: (child, animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                          );
                        }),
                  ),
          ),
        ],
      ),
    );
  }

  sendMessage() async {
    final chatNotifier = ref.read(River.chatsPod.notifier);
    ref.read(isSending.notifier).state = true;
    try {
      final selectedChatUid = ref.watch(River.chatsPod).selectedChat!.uid!;
      if (textController.text.isNotEmpty) {
        final myAcc = await ref.read(River.usersPod.notifier).getUserByUid();

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
            content: textController.text, receiverId: selectedChatUid);
        textController.clear();
        isMessageEmpty.value = true;
        ref.read(isSending.notifier).state = false;
        final lastMessageInChat = ref.watch(River.messagesPod).messages?.last;

        await chatNotifier.updateChatData({
          "last_message": lastMessageInChat?.content,
          "last_message_date": lastMessageInChat?.sentTime?.toIso8601String(),
          "message_receiver_id": lastMessageInChat?.receiverId,
        }, mainUid: UserPref.getUserUid, updatedChatUid: selectedChatUid);
        await chatNotifier.updateChatData({
          "last_message": lastMessageInChat?.content,
          "last_message_date": lastMessageInChat?.sentTime?.toIso8601String(),
          "message_receiver_id": lastMessageInChat?.receiverId,
        }, mainUid: selectedChatUid, updatedChatUid: UserPref.getUserUid);
      }
    } catch (e) {
      ref.read(isSending.notifier).state = false;
      if (mounted) {
        showDialog(
            context: context,
            builder: (ctx) => CupertinoAlertDialog(
                  title: const Text("Error"),
                  content: Text(e.toString()),
                ));
      }
    }
  }
}
