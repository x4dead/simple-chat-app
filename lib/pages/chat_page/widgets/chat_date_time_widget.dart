﻿part of '../chat_page.dart';

class ChatDateTimeWidget extends ConsumerWidget {
  const ChatDateTimeWidget(this.date, {super.key});
  final String date;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Divider(
            height: 2,
            color: AppColors.colorStroke,
            indent: 16,
          ),
        ),
        kSBW10,
        Text(Converting.getUpdateDate(date, isChatDateTime: true),
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.colorGray)),
        kSBW10,
        const Expanded(
          child: Divider(
            height: 2,
            color: AppColors.colorStroke,
            endIndent: 16,
          ),
        ),
      ],
    );
  }
}
