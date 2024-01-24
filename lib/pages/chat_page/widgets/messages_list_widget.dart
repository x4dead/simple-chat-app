part of '../chat_page.dart';

ScrollController scrollController = ScrollController();

class MessagesListWidget extends ConsumerStatefulWidget {
  const MessagesListWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MessageListWidgetState();
}

class _MessageListWidgetState extends ConsumerState<MessagesListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: StreamBuilder(
            stream: ref
                .read(River.messagesPod.notifier)
                .getMessages(ref.watch(River.chatsPod).selectedChat!.uid!),
            builder: (cts, snap) {
              if (snap.hasError) {
                return const Center(
                    child: Text(
                  'Error',
                  style: TextStyle(color: Colors.red),
                ));
              }

              if (snap.data?.isEmpty ?? true) {
                return const Center(
                  child: Text(
                    'Чат пуст',
                    style: TextStyle(color: AppColors.colorBlack),
                  ),
                );
              } else {
                return CustomScrollView(controller: scrollController, slivers: [
                  SliverList.builder(
                      itemCount: snap.data!.length,
                      itemBuilder: (ctx, index) {
                        bool isSameDate = true;
                        final item = snap.data![index];

                        final DateTime date = item.sentTime!;

                        if (index == 0) {
                          isSameDate = false;
                        } else {
                          final DateTime prevDate =
                              snap.data![index - 1].sentTime!;
                          isSameDate = date.day == prevDate.day;
                        }
                        if (index == 0 || !(isSameDate)) {
                          return Column(children: [
                            kSBH20,
                            ChatDateTimeWidget(date.toIso8601String()),
                            kSBH20,
                            MessageBubbleWidget(
                                item.receiverId != UserPref.getUserUid
                                    ? true
                                    : false,
                                message: item),
                          ]);
                        } else {
                          return MessageBubbleWidget(
                              item.receiverId != UserPref.getUserUid
                                  ? true
                                  : false,
                              message: item);
                        }
                      }),
                ]);
              }
            }));
  }
}
