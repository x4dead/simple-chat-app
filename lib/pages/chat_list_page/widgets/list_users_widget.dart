part of '../chat_list_page.dart';

class ListUserWidget extends ConsumerWidget {
  const ListUserWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: StreamBuilder(
          stream: ref.watch(River.chatsPod.notifier).getAllChatModels(),
          builder: (ctx, value) {
            if (value.hasError) {
              return Center(
                  child: Text(
                value.error.toString(),
                style: const TextStyle(color: Colors.red),
              ));
            } else if (value.data?.isEmpty ?? true) {
              return const Center(
                child: Text(
                  'Список чатов пуст',
                  style: TextStyle(color: AppColors.colorBlack),
                ),
              );
            } else {
              return CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemCount: value.data?.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder(
                          stream: ref
                              .watch(River.usersPod.notifier)
                              .getUser(value.data![index].uid!),
                          builder: (context, snap) {
                            return CustomListTile(
                              height: 70,
                              onTap: () {
                                ref
                                    .read(River.chatsPod.notifier)
                                    .setSelectedChat(value.data![index]);
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const ChatPage()));
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
                                  if (snap.data?.isOnline == true)
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
                                value.data![index].lastMessageDate != null ||
                                        snap.data?.lastActive != null
                                    ? Converting.getUpdateDate(value
                                            .data![index].lastMessageDate
                                            ?.toIso8601String() ??
                                        snap.data!.lastActive!
                                            .toIso8601String())
                                    : '',
                                style: const TextStyle(
                                  color: AppColors.colorDarkGray,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              titleMaxLines: 1,
                              title:
                                  "${value.data![index].firstName} ${value.data![index].lastName}",
                              titleStyle: TextStyle(
                                fontSize: 15,
                                color: AppColors.color000000,
                                fontWeight: FontWeight.bold,
                                height: 18.0.toFigmaHeight(15),
                              ),
                              subTitleWidget: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text: value.data![index].messageReceiverId !=
                                              UserPref.getUserUid &&
                                          value.data![index].lastMessage != null
                                      ? 'Вы: '
                                      : '',
                                  children: [
                                    TextSpan(
                                        text: value.data![index].lastMessage,
                                        style: TextStyle(
                                            color: AppColors.colorDarkGray,
                                            height: 14.56.toFigmaHeight(12)))
                                  ],
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.colorBlack,
                                      height: 15.0.toFigmaHeight(12)),
                                ),
                              ),
                            );
                          });
                    },
                  )
                ],
              );
            }
          }),
    );
  }
}
