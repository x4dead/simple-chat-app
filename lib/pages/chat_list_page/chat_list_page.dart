import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/models/models.dart';
import 'package:simple_chat_app/modules/signal_service/river/river.dart';
import 'package:simple_chat_app/pages/chat_list_page/widgets/chat_list_header.dart';
import 'package:simple_chat_app/pages/chat_list_page/widgets/list_users_widget.dart';
import 'package:simple_chat_app/pages/create_chat_page/create_chat_page.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';

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
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(River.usersPod.notifier).updateUserData({
          "last_active": DateTime.now().toIso8601String(),
          "is_online": true,
        });
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        ref.read(River.usersPod.notifier).updateUserData({"is_online": false});
        break;
      default:
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
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
            ChatListHeader(),
            ListUserWidget(),
          ],
        ),
      ),
    );
  }
}
