import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/models/models.dart';
import 'package:simple_chat_app/pages/chat_list_page/chat_list_page.dart';
import 'package:simple_chat_app/pages/chat_page/chat_page.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';

import 'package:simple_chat_app/utils/extentions/converting.dart';
import 'package:simple_chat_app/widgets/custom_list_tile.dart';

final List<UserDto> listUsers = List.generate(4, (index) {
  return UserDto(
      email: "email@mail.ru",
      firstName: "Саша",
      lastName: "Алексеев",
      isOnline: false,
      lastActive: DateTime(2024, 01, 19, 15, 50),
      password: "123456",
      uid: "uid");
});

class ListUserWidget extends ConsumerWidget {
  const ListUserWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ref.watch(userProvider).when(
          loading: () => const Center(child: CupertinoActivityIndicator()),
          error: (error, stackTrace) => const Center(
                  child: Text(
                'Error',
                style: TextStyle(color: Colors.red),
              )),
          data: (data) {
            return CustomScrollView(
              slivers: [
                SliverList.builder(
                  itemCount: data?.length,
                  itemBuilder: (context, index) {
                    return IntrinsicHeight(
                      child: CustomListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const ChatPage()));
                        },
                        horizontalTitleGap: 12,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 10, 32, 10),
                        isLeadingTop: false,
                        horizontalTrailingGap: 0,
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              gradient: AppColors.colorOrangeGradien),
                          child: Center(
                            child: Text(
                              Converting.getShortUserName(
                                  data![index].firstName!,
                                  data[index].lastName!),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.colorWhite,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),

                        trailing: Text(
                          Converting.getUpdateDate(
                              // snapshot
                              // .
                              data[index].lastActive!.toIso8601String()),
                          style: const TextStyle(
                            color: AppColors.colorDarkGray,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        //TODO

                        title:
                            "${data[index].firstName} ${data[index].lastName}",
                        titleStyle: const TextStyle(
                          fontSize: 15,
                          color: AppColors.color000000,
                          fontWeight: FontWeight.bold,
                        ),
                        subTitleWidget: RichText(
                          text: const TextSpan(
                            text: 'Вы: ',
                            children: [
                              TextSpan(
                                  text: 'Я готов',
                                  style:
                                      TextStyle(color: AppColors.colorDarkGray))
                            ],
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.colorBlack),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            );
          }),
    );
  }
}
