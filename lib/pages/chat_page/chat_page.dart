import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_chat_app/pages/chat_page/widgets/list_users_widget.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';
import 'package:simple_chat_app/utils/constants/ui_constants.dart';
import 'package:simple_chat_app/utils/extentions/converting.dart';
import 'package:simple_chat_app/utils/resources/app_images.dart';
import 'package:simple_chat_app/widgets/custom_list_tile.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final user = listUsers[1];
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Column(
        children: [
          CustomListTile(
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
                      padding: EdgeInsets.zero,
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
            subTitle: 'В сети',
            subTitleStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.colorDarkGray),
          ),
          const Divider(color: AppColors.colorStroke, height: 1),
        ],
      ),
    );
  }
}
