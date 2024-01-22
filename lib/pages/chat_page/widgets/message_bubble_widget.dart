import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_chat_app/models/src/message_dto.dart';
import 'package:simple_chat_app/pages/chat_page/widgets/message_tail_clipper.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';
import 'package:simple_chat_app/utils/constants/ui_constants.dart';
import 'package:simple_chat_app/utils/extentions/converting.dart';
import 'package:simple_chat_app/utils/extentions/media_query.dart';
import 'package:simple_chat_app/utils/resources/app_images.dart';

class MessageBubbleWidget extends ConsumerStatefulWidget {
  const MessageBubbleWidget(this.isMe, {super.key, required this.message});
  final bool isMe;
  final MessageDto message;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MessageBubbleWidgetState();
}

class _MessageBubbleWidgetState extends ConsumerState<MessageBubbleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.only(bottom: 8, right: 6, left: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!widget.isMe)
            Transform.flip(
              flipX: true,
              child: const CustomPaint(
                size: Size(10, 21),
                painter: MessageBubbleTailPaint(color: AppColors.colorStroke),
              ),
            ),
          Container(
            constraints:
                BoxConstraints(maxWidth: context.width - 80, minHeight: 33),
            clipBehavior: Clip.hardEdge,
            padding:
                const EdgeInsets.only(bottom: 4.0, left: 16, top: 8, right: 12),
            decoration: BoxDecoration(
              color:
                  widget.isMe ? AppColors.color3CED78 : AppColors.colorStroke,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(widget.isMe ? 16 : 0),
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomRight: Radius.circular(widget.isMe ? 0 : 16),
              ),
            ),
            child: Wrap(
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.end,
              runAlignment: WrapAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 4.0,
                  ),
                  child: SelectableText(
                    widget.message.content!,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: widget.isMe
                            ? AppColors.color00521C
                            : AppColors.colorBlack),
                  ),
                ),
                SizedBox(width: widget.isMe ? 15 : 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Converting.getMessageDate(widget.message.sentTime!),
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.isMe
                            ? AppColors.color00521C.withOpacity(0.8)
                            : AppColors.colorBlack.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (widget.isMe) ...[
                      kSBW4,
                      SvgPicture.asset(AppImages.unread, height: 12, width: 12),
                    ],
                  ],
                )
              ],
            ),
          ),
          if (widget.isMe)
            const CustomPaint(
              size: Size(10, 21),
              painter: MessageBubbleTailPaint(),
            ),
        ],
      ),
    );
  }
}
