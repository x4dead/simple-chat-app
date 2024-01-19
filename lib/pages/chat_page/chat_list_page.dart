import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/pages/chat_page/widgets/chat_list_header.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';

class ChatListPage extends ConsumerStatefulWidget {
  const ChatListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: SafeArea(
        child: const Column(
          children: [
            ChatListHeader(),
          ],
        ),
      ),
    );
  }
}
