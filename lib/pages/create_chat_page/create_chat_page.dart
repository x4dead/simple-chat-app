import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/modules/signal_service/river/river.dart';
import 'package:simple_chat_app/widgets/custom_chat_header.dart';
import 'package:simple_chat_app/pages/chat_page/chat_page.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';
import 'package:simple_chat_app/utils/extentions/converting.dart';
import 'package:simple_chat_app/widgets/custom_list_tile.dart';

import '../../models/models.dart';

final userProvider = StreamProvider<List<UserDto>?>(
  (ref) => ref.read(River.usersPod.notifier).getAllUsers(),
);

class CreateChatPage extends ConsumerWidget {
  const CreateChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BuildContext? loadingCtx;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomChatHeader(
              titleStyle: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorBlack),
              isGoBackButton: true,
              isSignOutButton: false,
              title: 'Создание чат',
            ),
            Expanded(
              child: StreamBuilder(
                  stream: ref.read(River.usersPod.notifier).getAllUsers(),
                  builder: (cts, snap) {
                    if (snap.hasError) {
                      return Center(
                          child: Text(
                        '${snap.error}',
                        style: const TextStyle(color: Colors.red),
                      ));
                    }

                    if (snap.data?.isEmpty ?? true) {
                      return const Center(
                        child: Text(
                          'Список пользователей пуст',
                          style: TextStyle(color: AppColors.colorBlack),
                        ),
                      );
                    } else {
                      return CustomScrollView(
                        slivers: [
                          SliverList.builder(
                            itemCount: snap.data?.length,
                            itemBuilder: (context, index) {
                              return IntrinsicHeight(
                                child: CustomListTile(
                                  onTap: () async {
                                    try {
                                      showCupertinoDialog(
                                        context: context,
                                        builder: (loadingContext) {
                                          loadingCtx = loadingContext;
                                          return const CupertinoActivityIndicator();
                                        },
                                      );
                                      ref
                                          .read(River.chatsPod.notifier)
                                          .setSelectedChat(ChatDto(
                                              firstName:
                                                  snap.data![index].firstName,
                                              isOnline:
                                                  snap.data![index].isOnline,
                                              lastActive:
                                                  snap.data![index].lastActive,
                                              lastName:
                                                  snap.data![index].lastName,
                                              uid: snap.data![index].uid));
                                      await ref
                                          .read(River.chatsPod.notifier)
                                          .createChat()
                                          .then((value) {
                                        if (loadingCtx != null) {
                                          Navigator.of(loadingCtx!).pop();
                                        }
                                        Navigator.of(context).pushReplacement(
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  const ChatPage()),
                                        );
                                      });
                                    } catch (e) {
                                      if (context.mounted) {
                                        if (loadingCtx != null) {
                                          Navigator.of(loadingCtx!).pop();
                                        }

                                        showDialog(
                                            context: context,
                                            builder: (ctx) =>
                                                CupertinoAlertDialog(
                                                  title: const Text("Error"),
                                                  content: Text(e.toString()),
                                                ));
                                      }
                                    }
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
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            gradient:
                                                AppColors.colorOrangeGradien),
                                        child: Center(
                                          child: Text(
                                            Converting.getShortUserName(
                                                snap.data![index].firstName!,
                                                snap.data![index].lastName!),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: AppColors.colorWhite,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (snap.data![index].isOnline == true)
                                        Positioned(
                                          bottom: 4,
                                          right: 0,
                                          child: Container(
                                            height: 10,
                                            width: 10,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: AppColors
                                                    .colorGreenGradien),
                                          ),
                                        )
                                    ],
                                  ),
                                  trailing: Text(
                                    Converting.getUpdateDate(snap
                                            .data![index].lastActive
                                            ?.toIso8601String() ??
                                        DateTime(0000).toIso8601String()),
                                    style: const TextStyle(
                                      color: AppColors.colorDarkGray,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  title:
                                      "${snap.data![index].firstName} ${snap.data![index].lastName}",
                                  titleStyle: const TextStyle(
                                    fontSize: 15,
                                    color: AppColors.color000000,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
