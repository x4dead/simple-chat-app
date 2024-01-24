part of '../chat_page.dart';

class ChatHeader extends ConsumerWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ChatDto user = ref.watch(River.chatsPod).selectedChat ?? ChatDto();
    return StreamBuilder(
        stream: ref.watch(River.usersPod.notifier).getOnlineStatus(user),
        builder: (context, snapshot) {
          return CustomListTile(
            height: 100,
            contentPadding: const EdgeInsets.fromLTRB(20, 38, 32, 12),
            horizontalTitleGap: 12,
            isLeadingTop: false,
            leading: Row(
              children: [
                ///SizedBox ограничивает по размеру кнопку как по дизайну
                SizedBox(
                  height: 36,
                  width: 36,
                  child: IconButton(
                      padding: kPZero,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: SvgPicture.asset(AppImages.arrowLeft)),
                ),
                kSBW6,
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      border: const Border(
                        bottom: BorderSide(
                          color: AppColors.colorStroke,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(100),
                      gradient: AppColors.colorOrangeGradien),
                  child: Center(
                    child: Text(
                      Converting.getShortUserName(
                          user.firstName!, user.lastName!),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.colorWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            title: "${user.firstName} ${user.lastName}",
            titleStyle: const TextStyle(
              fontSize: 15,
              color: AppColors.color000000,
              fontWeight: FontWeight.bold,
            ),
            subTitle: snapshot.data == true
                ? 'В сети'
                : user.lastActive != null
                    ? Converting.getUserLastActive(
                        user.lastActive!.toIso8601String())
                    : '',
            subTitleStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.colorDarkGray),
          );
        });
  }
}
