import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Converting {
  static String getMessageDate(DateTime createdDate) {
    final minute = createdDate.minute.toString().padLeft(2, '0');
    return "${createdDate.hour}:$minute";
  }

  static String getShortUserName(String firstName, String lastName) {
    return '${firstName.characters.first}${lastName.characters.first} ';
  }

  static String getUpdateDate(String updateDate) {
    final updatedDate = DateTime.parse(updateDate);
    final now = DateTime.now();
    final today = now.day;
    final yesterday = now.subtract(const Duration(days: 1)).day;
    final buffer = StringBuffer();
    final dateDiff = now.difference(updatedDate);

    if (updatedDate.day == today &&
        updatedDate.month == now.month &&
        updatedDate.year == now.year &&
        (dateDiff.inMinutes < 60 && !dateDiff.inMinutes.isNegative)) {
      buffer.write('${dateDiff.inMinutes} минут назад');
    } else if (updatedDate.day == today &&
        updatedDate.month == now.month &&
        updatedDate.year == now.year) {
      buffer.write(
          '${updatedDate.hour < 10 ? "0${updatedDate.hour}" : updatedDate.hour}:${updatedDate.minute < 10 ? "0${updatedDate.minute}" : updatedDate.minute}');
    } else if (updatedDate.day == yesterday &&
        updatedDate.month == now.month &&
        updatedDate.year == now.year) {
      buffer.write('Вчера');
    } else if (updatedDate.difference(now).inDays.abs() <= 6) {
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
    } else if (updatedDate.year == now.year) {
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
