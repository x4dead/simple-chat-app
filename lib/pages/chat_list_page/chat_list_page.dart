import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/modules/signal_service/river/river.dart';
import 'package:simple_chat_app/pages/chat_page/chat_page.dart';
import 'package:simple_chat_app/utils/extentions/converting.dart';
import 'package:simple_chat_app/utils/extentions/figma_height.dart';
import 'package:simple_chat_app/utils/user_pref.dart';
import 'package:simple_chat_app/widgets/custom_chat_header.dart';
import 'package:simple_chat_app/pages/create_chat_page/create_chat_page.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';
import 'package:simple_chat_app/widgets/custom_list_tile.dart';

part 'widgets/list_users_widget.dart';

class ChatListPage extends ConsumerStatefulWidget {
  const ChatListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatListPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.read(River.usersPod.notifier).updateUserData({
      "last_active": DateTime.now().toIso8601String(),
      "is_online": true,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.resumed:
        ref.read(River.usersPod.notifier).updateUserData({
          "last_active": DateTime.now().toIso8601String(),
          "is_online": true,
        });

        break;

      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        ref.read(River.usersPod.notifier).updateUserData({"is_online": false});

        break;
      default:
    }
  }

  @override
  void dispose() {
    ref.read(River.usersPod.notifier).updateUserData({"is_online": false});
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (ctx) => const CreateChatPage()));
          },
          backgroundColor: AppColors.colorStroke,
          child: const Icon(
            CupertinoIcons.chat_bubble,
            color: AppColors.colorBlack,
          )),
      backgroundColor: AppColors.colorWhite,
      body: const SafeArea(
        child: Column(
          children: [
            CustomChatHeader(),
            ListUserWidget(),
          ],
        ),
      ),
    );
  }
}
