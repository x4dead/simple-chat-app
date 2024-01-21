import 'package:simple_chat_app/utils/user_pref.dart';

class AuthStateRef {
  final bool isAuth;
  final bool isLoading;
  AuthStateRef({
    this.isLoading = false,
    this.isAuth = false,
  });
  // int get id => int.parse(UserPref.getUserId);
  String? get uid => UserPref.getUserUid;
  AuthStateRef copyWith({
    bool? isAuth,
    bool? isLoading,
  }) {
    return AuthStateRef(
      isLoading: isLoading ?? this.isLoading,
      isAuth: isAuth ?? this.isAuth,
    );
  }
}
