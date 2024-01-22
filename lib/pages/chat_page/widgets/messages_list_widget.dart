import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/models/src/message_dto.dart';
import 'package:simple_chat_app/modules/signal_service/river/river.dart';
import 'package:simple_chat_app/pages/chat_page/widgets/chat_date_time_widget.dart';
import 'package:simple_chat_app/pages/chat_page/widgets/message_bubble_widget.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';
import 'package:simple_chat_app/utils/constants/ui_constants.dart';
import 'package:simple_chat_app/utils/user_pref.dart';

final messagesProvider = StreamProvider<List<MessageDto>>((
  ref,
) {
  return ref
      .read(River.messagesPod.notifier)
      .getMessages(ref.watch(River.usersPod).mainUser!.uid!);
});
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
        child: ref.watch(messagesProvider).when(
            // data: (data) {},
            error: (error, s) => const Center(
                    child: Text(
                  'Error',
                  style: TextStyle(color: Colors.red),
                )),
            loading: () => const Center(
                  child: CupertinoActivityIndicator(),
                ),
            data: (data) {
              if (data.isEmpty) {
                return const Center(
                  child: Text(
                    'Чат пуст',
                    style: TextStyle(color: AppColors.colorBlack),
                  ),
                );
              } else {
                return CustomScrollView(controller: scrollController, slivers: [
                  SliverList.builder(
                      itemCount: data.length,
                      itemBuilder: (ctx, index) {
                        bool isSameDate = true;
                        final item = data[index];

                        final DateTime date = item.sentTime!;

                        if (index == 0) {
                          isSameDate = false;
                        } else {
                          final DateTime prevDate = data[index - 1].sentTime!;
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
