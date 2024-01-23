import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Converting {
  static String getMessageDate(DateTime createdDate) {
    final minute = createdDate.minute.toString().padLeft(2, '0');
    return "${createdDate.hour}:$minute";
  }

  static String getShortUserName(String firstName, String lastName) {
    return '${firstName.characters.first}${lastName.characters.first}'
        .toUpperCase();
  }

  static String getUserLastActive(String updateDate) {
    final updatedDate = DateTime.parse(updateDate);
    final now = DateTime.now();
    final today = now.day;
    final yesterday = now.subtract(const Duration(days: 1)).day;
    final buffer = StringBuffer();
    final time =
        ' ${updatedDate.hour < 10 ? "0${updatedDate.hour}" : updatedDate.hour}:${updatedDate.minute < 10 ? "0${updatedDate.minute}" : updatedDate.minute}';

    if (updatedDate.day == today &&
        updatedDate.month == now.month &&
        updatedDate.year == now.year) {
      buffer.write('сегодня в $time');
    } else if (updatedDate.day == yesterday &&
        updatedDate.month == now.month &&
        updatedDate.year == now.year) {
      buffer.write('вчера в $time');
    } else {
      final dateFormat = DateFormat(
        'dd.MM.yy',
      );
      buffer.write("${dateFormat.format(updatedDate)} в $time");
    }
    return "был(-а) $buffer";
  }

  static String getUpdateDate(String updateDate,
      {bool? isChatDateTime = false}) {
    final updatedDate = DateTime.parse(updateDate);
    final now = DateTime.now();
    final today = now.day;
    final yesterday = now.subtract(const Duration(days: 1)).day;
    final buffer = StringBuffer();
    final dateDiff = now.difference(updatedDate);

    if (updatedDate.day == today &&
        updatedDate.month == now.month &&
        updatedDate.year == now.year &&
        (dateDiff.inMinutes < 60 &&
            !dateDiff.inMinutes.isNegative &&
            isChatDateTime == false)) {
      buffer.write(dateDiff.inMinutes < 1
          ? "только что"
          : " ${dateDiff.inMinutes} минут назад");
    } else if (updatedDate.day == today &&
        updatedDate.month == now.month &&
        updatedDate.year == now.year &&
        isChatDateTime == false) {
      buffer.write(
          '${updatedDate.hour < 10 ? "0${updatedDate.hour}" : updatedDate.hour}:${updatedDate.minute < 10 ? "0${updatedDate.minute}" : updatedDate.minute}');
    } else if (updatedDate.day == yesterday &&
        updatedDate.month == now.month &&
        updatedDate.year == now.year) {
      buffer.write('Вчера');
    } else if (updatedDate.day == now.day &&
        updatedDate.month == now.month &&
        updatedDate.year == now.year &&
        isChatDateTime == true) {
      buffer.write('Сегодня');
    } else if (dateDiff.inDays.abs() <= 6 &&
        (!dateDiff.inDays.isNegative && dateDiff.inDays.abs() != 0)) {
      final dayOfWeek = DateFormat.E().format(updatedDate);
      buffer.write(switch (dayOfWeek.toLowerCase()) {
        'mon' => 'Понидельник',
        'tue' => 'Вторник',
        'wed' => 'Среда',
        'thu' => 'Четверг',
        'fri' => 'Пятница',
        'sat' => 'Суббота',
        'sun' => 'Воскресенье',
        _ => 'none'
      });
    } else if (updatedDate.year == now.year && isChatDateTime == false) {
      final dateFormat = DateFormat('d MMM');

      buffer.write(dateFormat.format(updatedDate));
    } else {
      final dateFormat = DateFormat(
        'dd.MM.yy',
      );
      buffer.write(dateFormat.format(updatedDate));
    }
    return buffer.toString();
  }
}
