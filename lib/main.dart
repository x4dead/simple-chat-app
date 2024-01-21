import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/firebase_options.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';
import 'package:simple_chat_app/utils/router/router.dart';
import 'package:simple_chat_app/utils/user_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPref.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.router;

    return MaterialApp.router(
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Gilroy',
          textSelectionTheme: TextSelectionThemeData(
              selectionColor: AppColors.colorGray.withOpacity(0.5),
              selectionHandleColor: AppColors.colorDarkGray)),
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      builder: (context, child) => child!,
      title: 'Simple cupertino chat app',
    );
  }
}
