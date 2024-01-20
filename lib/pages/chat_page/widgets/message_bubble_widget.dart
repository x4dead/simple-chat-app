import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_chat_app/pages/chat_page/widgets/message_tail_clipper.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';
import 'package:simple_chat_app/utils/constants/ui_constants.dart';
import 'package:simple_chat_app/utils/extentions/media_query.dart';
import 'package:simple_chat_app/utils/resources/app_images.dart';

class MessageBubbleWidget extends ConsumerStatefulWidget {
  const MessageBubbleWidget(this.isMe, {super.key});
  final bool isMe;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MessageBubbleWidgetState();
}

class _MessageBubbleWidgetState extends ConsumerState<MessageBubbleWidget> {
  @override
  Widget build(BuildContext context) {
    const maxLength500 =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ut aliquam dui, vel consequat felis. Fusce semper dui ac elit imperdiet lobortis. Curabitur quis dolor interdum, tincidunt justo sit amet, venenatis velit. Mauris convallis ante elit, nec auctor elit euismod id. Nam ultrices purus eu turpis sagittis venenatis. Mauris ut ullamcorper ex. Nullam nec lacinia nisi. Duis orci mauris, elementum id facilisis a, ullamcorper sed massa. Donec sollicitudin nulla non elit luctus, vel vulputate eu.';
    const maxLength1000 =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer aliquet, nisi ac vestibulum mattis, nibh dui auctor mi, a tristique erat lacus quis libero. Fusce aliquam dictum ex a finibus. Nullam quis velit quis dui porta consectetur. Praesent dapibus mi eu elit viverra rutrum. Nam pulvinar lectus sit amet sem ullamcorper, ut varius ligula semper. Morbi mi erat, porttitor et varius sit amet, dignissim nec diam. Pellentesque vel enim quis sem sollicitudin iaculis. Morbi ac tempor felis. Aliquam erat volutpat. Sed at elementum dui, nec sodales dolor. Mauris tincidunt ipsum vitae nunc finibus, vel placerat lacus gravida. Praesent vestibulum quis neque vel mollis. Nullam a laoreet eros, in consectetur lectus. Ut feugiat arcu ante, vel maximus felis sollicitudin eu. Integer et ornare purus. Donec finibus auctor diam et blandit. Vestibulum eros ante, volutpat ac odio bibendum, lacinia egestas quam. Pellentesque pellentesque consequat auctor. Donec vel elit vitae nisi aliquam luctus tellus.';
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
                    // maxLength1000,
                    // maxLength500,
                    // '21:4121:4121:4121:4121:4121:4121:41DAdassdasdasdsaСделай мне кофе, пожалуйста',
                    'Сделай мне кофе, пожалуйста',
                    // "Окей",
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
                      '21:41',
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
