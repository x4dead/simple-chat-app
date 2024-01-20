import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:simple_chat_app/modules/signal_service/user_ref/user_notifier.dart';
import 'package:simple_chat_app/modules/signal_service/user_ref/user_state_ref.dart';

///
///Константы для вызова риверпода
///

class River {
  static final usersPod = StateNotifierProvider<UserNotifier, UserStateRef>(
      (ref) => UserNotifier());
}
