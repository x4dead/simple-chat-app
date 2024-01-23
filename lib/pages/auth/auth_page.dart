// part of '../login_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_chat_app/models/src/user_dto.dart';
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

class _AuthPageState extends ConsumerState<AuthPage> {
  BuildContext? loadingCtx;
  final _isObscure = StateProvider<bool>((ref) => false);
  final _isConfirmPasswordObscure = StateProvider<bool>((ref) => false);
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
          ref.read(_isSignIn.notifier).state = true;
        }
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Center(
            child: SingleChildScrollView(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      ref.watch(_isSignIn) == true
                          ? 'Привет!'
                          : 'Зарегистрироваться',
                      style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: ref.watch(_isSignIn) == true ? 42 : 32,
                          color: AppColors.colorBlack),
                    ),
                    Text(
                      ref.watch(_isSignIn) == true
                          ? 'Добро пожаловать'
                          : 'Создать учетную запись',
                      style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: AppColors.colorBlack),
                    ),
                    kSBH25,
                    AppTextField(
                        inputFormatters: FieldFormClass.regExpEmail,
                        controller: ref.watch(_isSignIn) == true
                            ? loginEmailController
                            : signUpEmailController,
                        icon: CupertinoIcons.mail,
                        maxLength: 36,
                        text: 'Почта',
                        validator: (email) =>
                            FieldFormClass.validatorEmail(email)),
                    kSBH5,
                    AppTextField(
                      inputFormatters: FieldFormClass.regExpPassword,
                      controller: ref.watch(_isSignIn) == true
                          ? loginPasswordController
                          : signUpPasswordController,
                      icon: CupertinoIcons.lock,
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
                              ? CupertinoIcons.eye_fill
                              : CupertinoIcons.eye_slash_fill,
                          color: AppColors.colorBlack.withOpacity(0.9),
                        ),
                      ),
                    ),
                    if (ref.watch(_isSignIn) == false) ...[
                      kSBH5,
                      AppTextField(
                        inputFormatters: FieldFormClass.regExpPassword,
                        controller: ref.watch(_isSignIn) == true
                            ? loginPasswordController
                            : signUpConfirmPasswordController,
                        icon: CupertinoIcons.lock,
                        obscureText: ref.watch(_isConfirmPasswordObscure),
                        maxLength: 32,
                        text: 'Подтвердить пароль',
                        validator: (password) =>
                            FieldFormClass.validatorNewPasswords(
                                password ?? '', signUpPasswordController.text),
                        suffix: IconButton(
                          splashRadius: 15,
                          onPressed: () {
                            if (ref.watch(_isConfirmPasswordObscure) == true) {
                              ref
                                  .read(_isConfirmPasswordObscure.notifier)
                                  .state = false;
                            } else {
                              ref
                                  .read(_isConfirmPasswordObscure.notifier)
                                  .state = true;
                            }
                          },
                          icon: Icon(
                            ref.watch(_isConfirmPasswordObscure) == true
                                ? CupertinoIcons.eye_fill
                                : CupertinoIcons.eye_slash_fill,
                            color: AppColors.colorBlack.withOpacity(0.9),
                          ),
                        ),
                      ),
                      kSBH5,
                      AppTextField(
                        text: 'Имя',
                        maxLength: 36,
                        icon: CupertinoIcons.person,
                        inputFormatters: FieldFormClass.regExpName,
                        validator: (name) => FieldFormClass.validatorName(name),
                        controller: firstNameController,
                      ),
                      kSBH5,
                      AppTextField(
                        text: 'Фамилия',
                        maxLength: 36,
                        icon: CupertinoIcons.person,
                        inputFormatters: FieldFormClass.regExpName,
                        validator: (name) => FieldFormClass.validatorName(name),
                        controller: lastNameController,
                      ),
                    ],
                    kSBH20,
                    ElevatedButton(
                      style: ButtonStyle(
                          elevation: const MaterialStatePropertyAll(2),
                          alignment: Alignment.center,
                          backgroundColor: const MaterialStatePropertyAll(
                              AppColors.colorWhite),
                          fixedSize: const MaterialStatePropertyAll(
                              Size(double.infinity, 60)),
                          overlayColor: MaterialStatePropertyAll(
                              AppColors.colorBlack.withOpacity(0.08))),
                      onPressed: () async {
                        if (ref.watch(_isSignIn) == true
                            ? (FieldFormClass.validatorEmail(loginEmailController.text) ==
                                    null &&
                                FieldFormClass.validatorPassword(
                                        loginPasswordController.text) ==
                                    null)
                            : (FieldFormClass.validatorEmail(
                                            signUpEmailController.text) ==
                                        null &&
                                    FieldFormClass.validatorPassword(
                                            signUpPasswordController.text) ==
                                        null) &&
                                FieldFormClass.validatorNewPasswords(
                                        signUpConfirmPasswordController.text,
                                        signUpPasswordController.text) ==
                                    null &&
                                FieldFormClass.validatorName(firstNameController.text) ==
                                    null &&
                                FieldFormClass.validatorName(lastNameController.text) ==
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
                            if (ref.watch(_isSignIn) == true) {
                              await ref.read(River.authPod.notifier).login(
                                  email: loginEmailController.text,
                                  password: loginPasswordController.text);
                            } else {
                              await ref.read(River.authPod.notifier).signUp(
                                  user: UserDto(
                                      firstName: firstNameController.text,
                                      lastActive: DateTime.now(),
                                      lastName: lastNameController.text,
                                      email: signUpEmailController.text,
                                      password: signUpPasswordController.text));
                            }
                            if (mounted) {
                              context.go('/chat_list');
                            }

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
                                        title: const Text("Error"),
                                        content: Text(e.toString()),
                                      ));
                            }
                          }
                        }
                      },
                      child: Center(
                        child: Text(
                          ref.watch(_isSignIn) == true
                              ? 'Войти'
                              : "Зарегистрироваться",
                          style: const TextStyle(
                              fontSize: 20,
                              color: AppColors.colorBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    kSBH20,
                    RichText(
                      text: TextSpan(
                        text: ref.watch(_isSignIn) == true
                            ? "Не зарегистрированы? "
                            : 'У вас уже есть аккаунт? ',
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
                              child: Text(
                                  ref.watch(_isSignIn) == true
                                      ? "Зарегистрироваться"
                                      : 'Войти',
                                  style: const TextStyle(
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
      ),
    );
  }
}
