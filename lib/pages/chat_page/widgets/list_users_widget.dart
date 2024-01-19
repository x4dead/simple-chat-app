import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:simple_chat_app/models/models.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';

import 'package:simple_chat_app/utils/extentions/converting.dart';
import 'package:simple_chat_app/widgets/custom_list_tile.dart';

class ListUserWidget extends ConsumerStatefulWidget {
  const ListUserWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListUserWidgetState();
}

class _ListUserWidgetState extends ConsumerState<ListUserWidget> {
  @override
  Widget build(BuildContext context) {
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

    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverList.builder(
            itemCount: listUsers.length,
            itemBuilder: (context, index) {
              return IntrinsicHeight(
                child: CustomListTile(
                  onTap: () {
                    // CupertinoPage(child: child)
                  },
                  horizontalTitleGap: 12,
                  contentPadding: const EdgeInsets.fromLTRB(20, 10, 32, 10),
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
                        Converting.getShortUserName(listUsers[index].firstName!,
                            listUsers[index].lastName!),
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
                        listUsers[index].lastActive!.toIso8601String()),
                    style: const TextStyle(
                      color: AppColors.colorDarkGray,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  //TODO

                  title:
                      "${listUsers[index].firstName} ${listUsers[index].lastName}",
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
                            style: TextStyle(color: AppColors.colorDarkGray))
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
      ),
    );
  }
}
