import 'package:flutter/material.dart';
import 'package:flutter_app/utils/router/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      builder: (context, child) => child!,
      title: 'Simple cupertino chat app',
    );
  }
}
