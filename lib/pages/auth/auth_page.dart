// part of '../login_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_chat_app/modules/signal_service/river/river.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';
import 'package:simple_chat_app/utils/constants/ui_constants.dart';
import 'package:simple_chat_app/widgets/app_text_field.dart';
import 'package:simple_chat_app/widgets/field_from_class.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

// final isDark = ValueNotifier<bool>(false);
// Locale? locale;

class _AuthPageState extends ConsumerState<AuthPage> {
  BuildContext? loadingCtx;
  final _isObscure = StateProvider<bool>((ref) => false);

  final _isSignIn = StateProvider<bool>((ref) => true);

  ///sign up
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController =
      TextEditingController();
  final TextEditingController signUpConfirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  ///login
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController loginEmailController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    signUpConfirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    loginPasswordController.dispose();
    loginEmailController.dispose();
    super.dispose();
  }

  VoidCallback toggleScreenOrButton({bool isButton = false}) {
    return () {
      if (isButton == true) {
        if (ref.watch(_isObscure) == true) {
          ref.read(_isObscure.notifier).state = false;
        } else {
          ref.read(_isObscure.notifier).state = true;
        }
      } else {
        if (ref.watch(_isSignIn) == true) {
          ref.read(_isSignIn.notifier).state = false;
        } else {
          ref.read(_isSignIn.notifier).state = false;
        }
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    materialProperty(value) => MaterialStatePropertyAll(value);
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Center(
          child: SingleChildScrollView(
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Привет!',
                    style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 42,
                        color: AppColors.colorBlack),
                  ),
                  Text(
                    'Добро пожаловать',
                    style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: AppColors.colorBlack),
                  ),
                  const SizedBox(height: 25),
                  AppTextField(
                      inputFormatters: FieldFormClass.regExpEmail,
                      controller: loginEmailController,
                      icon: Icons.mail_outline_rounded,
                      maxLength: 36,
                      text: 'Почта',
                      validator: (email) =>
                          FieldFormClass.validatorEmail(email)),
                  const SizedBox(height: 10),
                  AppTextField(
                    inputFormatters: FieldFormClass.regExpPassword,
                    controller: loginPasswordController,
                    icon: Icons.lock_outline_rounded,
                    obscureText: ref.watch(_isObscure),
                    maxLength: 32,
                    text: 'Пароль',
                    validator: (password) =>
                        FieldFormClass.validatorPassword(password),
                    suffix: IconButton(
                      splashRadius: 15,
                      onPressed: toggleScreenOrButton(isButton: true),
                      icon: Icon(
                        ref.watch(_isObscure) == true
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        color: AppColors.colorBlack,
                      ),
                    ),
                  ),
                  kSBH20,
                  ElevatedButton(
                    style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(2),
                        alignment: Alignment.center,
                        fixedSize: const MaterialStatePropertyAll(
                            Size(double.infinity, 60)),
                        overlayColor: MaterialStatePropertyAll(
                            AppColors.colorBlack.withOpacity(0.08))),
                    onPressed: () async {
                      if (FieldFormClass.validatorEmail(
                                  loginEmailController.text) ==
                              null &&
                          FieldFormClass.validatorPassword(
                                  loginPasswordController.text) ==
                              null) {
                        try {
                          showCupertinoDialog(
                            context: context,
                            builder: (loadingContext) {
                              loadingCtx = loadingContext;
                              return const CupertinoActivityIndicator();
                            },
                          );
                          await Future.delayed(const Duration(seconds: 2));
                          await ref
                              .read(River.authPod.notifier)
                              .login(
                                  email: loginEmailController.text,
                                  password: loginPasswordController.text)
                              .then((value) {
                            context.go('/chat');
                          });

                          if (loadingCtx != null) {
                            Navigator.of(loadingCtx!).pop();
                          }
                        } catch (e) {
                          if (loadingCtx != null) {
                            Navigator.of(loadingCtx!).pop();
                          }
                          if (mounted) {
                            showDialog(
                                context: context,
                                builder: (ctx) => CupertinoAlertDialog(
                                      title: Text(e.toString()),
                                    ));
                          }
                        }
                      }
                    },
                    child: const Center(
                      child: Text(
                        'Войти',
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors.colorBlack,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  kSBH20,
                  RichText(
                    text: TextSpan(
                      text: "Не зарегистрированы? ",
                      style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.colorBlack,
                          fontFamily: 'Gilroy'),
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: InkWell(
                            overlayColor: MaterialStatePropertyAll(
                                AppColors.colorBlack.withOpacity(0.07)),
                            onTap: toggleScreenOrButton(),
                            child: const Text("Зарегистрироваться",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.colorDarkGray)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
