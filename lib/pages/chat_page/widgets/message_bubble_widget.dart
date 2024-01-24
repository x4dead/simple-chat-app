part of '../chat_page.dart';

class MessageBubbleWidget extends StatelessWidget {
  const MessageBubbleWidget(this.isMe, {super.key, required this.message});
  final bool isMe;
  final MessageDto message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.only(bottom: 8, right: 6, left: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe)
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
              color: isMe ? AppColors.color3CED78 : AppColors.colorStroke,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(isMe ? 16 : 0),
                topLeft: bubbleRadius,
                topRight:bubbleRadius,
                bottomRight: Radius.circular(isMe ? 0 : 16),
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
                    message.content!,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isMe
                            ? AppColors.color00521C
                            : AppColors.colorBlack),
                  ),
                ),
                SizedBox(width: isMe ? 15 : 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Converting.getMessageDate(message.sentTime!),
                      style: TextStyle(
                        fontSize: 12,
                        color: isMe
                            ? AppColors.color00521C.withOpacity(0.8)
                            : AppColors.colorBlack.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (isMe) ...[
                      kSBW4,
                      SvgPicture.asset(AppImages.unread, height: 12, width: 12),
                    ],
                  ],
                )
              ],
            ),
          ),
          if (isMe)
            const CustomPaint(
              size: Size(10, 21),
              painter: MessageBubbleTailPaint(),
            ),
        ],
      ),
    );
  }
}
