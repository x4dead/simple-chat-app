import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_chat_app/pages/auth/auth_page.dart';
import 'package:simple_chat_app/pages/chat_list_page/chat_list_page.dart';
import 'package:simple_chat_app/pages/chat_page/chat_page.dart';
import 'package:simple_chat_app/pages/create_chat_page/create_chat_page.dart';
import 'package:simple_chat_app/utils/router/fade_transition.dart';
import 'package:simple_chat_app/utils/user_pref.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final shellNavigatorKey = GlobalKey<NavigatorState>();
  static final sectionShellKey = GlobalKey<NavigatorState>();
  static final GoRouter router = GoRouter(
      navigatorKey: navigatorKey,
      debugLogDiagnostics: true,
      observers: [GoRouterObserver()],
      initialLocation: '/',
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          redirect: (_, __) {
            if (UserPref.getUserUid != '') {
              return '/chat_list';
            } else {
              return '/auth';
            }
          },
        ),
        GoRoute(
          path: '/auth',
          pageBuilder: (context, state) {
            return FadeTransitionPage(
                child: const AuthPage(), key: state.pageKey);
          },
        ),
        GoRoute(
          path: '/chat_list',
          pageBuilder: (context, state) {
            return FadeTransitionPage(
                child: const ChatListPage(), key: state.pageKey);
          },
        ),
        GoRoute(
          path: '/chat',
          pageBuilder: (context, state) {
            return FadeTransitionPage(
                child: const ChatPage(), key: state.pageKey);
          },
        ),
        GoRoute(
          path: '/create_chat',
          pageBuilder: (context, state) {
            return FadeTransitionPage(
                child: const CreateChatPage(), key: state.pageKey);
          },
        ),
      ],
      errorBuilder: (context, state) =>
          const Scaffold(body: Center(child: Text('Not found'))));
}

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyTest didPush: $route');
    log('MyTest didPush pref: $previousRoute');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyTest didPop: $route');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyTest didRemove: $route');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    log('MyTest didReplace: $newRoute');
  }
}
