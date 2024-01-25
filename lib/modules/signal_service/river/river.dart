import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/modules/signal_service/auth_ref/auth_notifier.dart';
import 'package:simple_chat_app/modules/signal_service/auth_ref/auth_state_ref.dart';
import 'package:simple_chat_app/modules/signal_service/chat_ref/chat_notifier.dart';
import 'package:simple_chat_app/modules/signal_service/chat_ref/chat_state_ref.dart';
import 'package:simple_chat_app/modules/signal_service/message_ref/message_notifier.dart';
import 'package:simple_chat_app/modules/signal_service/message_ref/message_state_ref.dart';

import 'package:simple_chat_app/modules/signal_service/user_ref/user_notifier.dart';
import 'package:simple_chat_app/modules/signal_service/user_ref/user_state_ref.dart';

///
///Константы для вызова риверпода
///

class River {
  static final usersPod = StateNotifierProvider<UserNotifier, UserStateRef>(
      (ref) => UserNotifier());
  static final chatsPod = StateNotifierProvider<ChatNotifier, ChatStateRef>(
      (ref) => ChatNotifier());
  static final messagesPod =
      StateNotifierProvider<MessageNotifier, MessageStateRef>(
          (ref) => MessageNotifier());
  static final authPod = StateNotifierProvider<AuthNotifier, AuthStateRef>(
      (ref) => AuthNotifier());
}
