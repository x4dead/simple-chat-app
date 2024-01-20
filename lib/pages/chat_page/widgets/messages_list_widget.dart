import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/pages/chat_page/widgets/chat_date_time_widget.dart';
import 'package:simple_chat_app/pages/chat_page/widgets/message_bubble_widget.dart';
import 'package:simple_chat_app/utils/constants/ui_constants.dart';

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
      child: CustomScrollView(reverse: true, slivers: [
        SliverList.builder(
            itemCount: 3,
            itemBuilder: (ctx, index) {
              return Column(
                children: [
                  if (index == 0)
                    ChatDateTimeWidget(
                        DateTime(2024, 01, 21).toIso8601String()),
                  kSBH20,
                  const MessageBubbleWidget(),
                ],
              );
            }),
      ]),
    );
  }
}
