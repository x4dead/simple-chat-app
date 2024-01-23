import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/modules/signal_service/river/river.dart';
import 'package:simple_chat_app/pages/chat_list_page/chat_list_page.dart';
import 'package:simple_chat_app/pages/chat_page/chat_page.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';

import 'package:simple_chat_app/utils/extentions/converting.dart';
import 'package:simple_chat_app/utils/user_pref.dart';
import 'package:simple_chat_app/widgets/custom_list_tile.dart';

class ListUserWidget extends ConsumerWidget {
  const ListUserWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child:
          // ref.watch(chatProvider).when(
          // loading: () => const Center(child: CupertinoActivityIndicator()),
          // error: (error, stackTrace) => const Center(
          // child: Text(
          // 'Error',
          // style: TextStyle(color: Colors.red),
          // )),
          StreamBuilder(
              stream: ref.watch(River.chatsPod.notifier).getAllChats(),
              builder: (ctx, value) {
                if (value.hasError) {
                  return const Center(
                      child: Text(
                    'Error',
                    style: TextStyle(color: Colors.red),
                  ));
                }
                if (value.data?.isEmpty ?? true) {
                  return const Center(
                    child: Text(
                      'Список чатов пуст',
                      style: TextStyle(color: AppColors.colorBlack),
                    ),
                  );
                }
                // data: (data) {
                return CustomScrollView(
                  slivers: [
                    SliverList.builder(
                      itemCount: value.data?.length,
                      itemBuilder: (context, index) {
                        return IntrinsicHeight(
                          child: CustomListTile(
                            onTap: () {
                              ref
                                  .read(River.chatsPod.notifier)
                                  .setSelectedChat(value.data![index]);
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => const ChatPage()));
                            },
                            horizontalTitleGap: 12,
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 10, 32, 10),
                            isLeadingTop: false,
                            horizontalTrailingGap: 0,
                            leading: Stack(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      gradient: AppColors.colorOrangeGradien),
                                  child: Center(
                                    child: Text(
                                      Converting.getShortUserName(
                                          value.data![index].firstName!,
                                          value.data![index].lastName!),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: AppColors.colorWhite,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                if (value.data![index].isOnline == true)
                                  Positioned(
                                    bottom: 4,
                                    right: 0,
                                    child: Container(
                                      height: 10,
                                      width: 10,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient:
                                              AppColors.colorGreenGradien),
                                    ),
                                  )
                              ],
                            ),
                            trailing: Text(
                              Converting.getUpdateDate(value
                                      .data![index].lastMessageDate
                                      ?.toIso8601String() ??
                                  value.data![index].lastActive!
                                      .toIso8601String()),
                              style: const TextStyle(
                                color: AppColors.colorDarkGray,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            title:
                                "${value.data![index].firstName} ${value.data![index].lastName}",
                            titleStyle: const TextStyle(
                              fontSize: 15,
                              color: AppColors.color000000,
                              fontWeight: FontWeight.bold,
                            ),
                            subTitleWidget: RichText(
                              text: TextSpan(
                                text: value.data![index].messageReceiverId !=
                                            UserPref.getUserUid &&
                                        value.data![index].lastMessage != null
                                    ? 'Вы: '
                                    : '',
                                children: [
                                  TextSpan(
                                      text: value.data![index].lastMessage,
                                      style: const TextStyle(
                                          color: AppColors.colorDarkGray))
                                ],
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.colorBlack),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                );
              }),
    );
  }
}
