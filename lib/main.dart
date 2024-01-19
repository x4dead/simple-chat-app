import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/utils/router/router.dart';

void main() async {
  //await AppInit.init();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = AppRouter.router;

    return MaterialApp.router(
      theme: ThemeData(useMaterial3: true, fontFamily: 'Gilroy'),
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      builder: (context, child) => child!,
      title: 'Simple cupertino chat app',
    );
  }
}
