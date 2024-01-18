// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:sfera_web/model/models.dart';
// import 'package:sfera_web/utils/utils.dart';

// class Converting {
//   static String formatDurationPosition(Duration position) {
//     int seconds = position.inSeconds;
//     final days = seconds ~/ Duration.secondsPerDay;
//     seconds -= days * Duration.secondsPerDay;
//     final hours = seconds ~/ Duration.secondsPerHour;
//     seconds -= hours * Duration.secondsPerHour;
//     final minutes = seconds ~/ Duration.secondsPerMinute;
//     seconds -= minutes * Duration.secondsPerMinute;

//     final buffer = StringBuffer();
//     if (days != 0) {
//       buffer.write(days);
//     }
//     if (hours != 0) {
//       if (buffer.isNotEmpty) buffer.write(':');
//       buffer.write(hours);
//     }
//     if (minutes != 0) {
//       if (buffer.isNotEmpty) buffer.write(':');
//       buffer.write(minutes);
//     } else {
//       buffer.write('0');
//     }
//     buffer.write(
//         ':${seconds < 10 ? '0' : ''}${seconds.toStringAsFixed(1).replaceAll(RegExp(r'\.0+$'), '')}');

//     return buffer.toString();
//   }
//   //TODO: need localizations

//   static String convertBytes(int size) {
//     if (size <= 1024) {
//       return '$size Byte';
//     } else if (size < 1024 * 1024) {
//       return '${(size / 1024).toStringAsFixed(2)} Kb';
//     } else {
//       return '${(size / (1024 * 1024)).toStringAsFixed(2)} Mb';
//     }
//   }

//   static int convertStringToBytes(String size) {
//     final scallSize = size.split(' ');
//     return switch (scallSize.last) {
//       'Byte' => double.parse(scallSize.first),
//       'Kb' => double.parse(scallSize.first) * 1024,
//       'Mb' => double.parse(scallSize.first) * 1024 * 1024,
//       _ => 0
//     }
//         .toInt();
//   }

//   static String? convertMillisecondsToTime(int? seconds) {
//     if (seconds == null || seconds == 0) {
//       return null;
//     }
//     late final int sec;
//     final int minutes = seconds ~/ 1000 ~/ 60;
//     sec = seconds ~/ 1000 % 60;
//     return "${minutes.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
//   }

//   static String? convertSecondsToTime(int? seconds) {
//     if (seconds == null || seconds == 0) {
//       return null;
//     }
//     late final int sec;
//     final int minutes = seconds ~/ 60;
//     sec = seconds % 60;
//     return "${minutes.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
//   }

//   static String getDate(String createdDate) {
//     final date = DateTime.parse(createdDate);
//     final correctDay = date.day.toString().padLeft(2, '0');
//     final correctMonth = date.month.toString().padLeft(2, '0');
//     final now = DateTime.now();
//     final today =
//         date.day == now.day && date.month == now.month && date.year == now.year;
//     return today
//         ? navigatorKey.currentContext!.localization.today
//         : '$correctDay.$correctMonth.${date.year}';
//   }

//   static String getMessageDate(DateTime createdDate) {
//     final minute = createdDate.minute.toString().padLeft(2, '0');
//     return "${createdDate.hour}:$minute";
//   }

//   static Future<Size> getNetworkImageSize({required String imgUrl}) {
//     final Completer<Size> completer = Completer();
//     final image = Image.network(imgUrl);
//     // ignore: prefer_const_constructors
//     image.image.resolve(ImageConfiguration()).addListener(
//       ImageStreamListener(
//         (ImageInfo image, bool synchronousCall) {
//           final myImage = image.image;
//           final size =
//               Size(myImage.width.toDouble(), myImage.height.toDouble());
//           completer.complete(size);
//         },
//       ),
//     );
//     return completer.future;
//   }

//   static String getShortUpdateDate(String updateDate) {
//     final updatedDate = DateTime.parse(updateDate);
//     final correctDay = updatedDate.day.toString().padLeft(2, '0');
//     final thisYear = DateTime.now().year;
//     final correctMonth = updatedDate.month.toString().padLeft(2, '0');
//     final correctUpdatedDate = updatedDate.year == thisYear
//         ? '$correctDay.$correctMonth'
//         : '$correctDay.$correctMonth.${updatedDate.year}';
//     return correctUpdatedDate;
//   }

//   static String getUpdateDate(String updateDate) {
//     final updatedDate = DateTime.parse(updateDate);
//     final now = DateTime.now();
//     final today = now.day;
//     final yesterday = now.subtract(const Duration(days: 1)).day;
//     final buffer = StringBuffer();
//     if (updatedDate.day == today &&
//         updatedDate.month == now.month &&
//         updatedDate.year == now.year) {
//       buffer.write(
//           '${updatedDate.hour < 10 ? "0${updatedDate.hour}" : updatedDate.hour}:${updatedDate.minute < 10 ? "0${updatedDate.minute}" : updatedDate.minute}');
//     } else if (updatedDate.day == yesterday &&
//         updatedDate.month == now.month &&
//         updatedDate.year == now.year) {
//       buffer.write(navigatorKey.currentContext!.localization.yesterday);
//     } else if (updatedDate.difference(now).inDays.abs() <= 6) {
//       final dayOfWeek = DateFormat.E(
//               Localizations.localeOf(navigatorKey.currentContext!).languageCode)
//           .format(updatedDate);
//       buffer.write(dayOfWeek);
//     } else if (updatedDate.year == now.year) {
//       final dateFormat = DateFormat('d MMM',
//           Localizations.localeOf(navigatorKey.currentContext!).languageCode);
//       buffer.write(dateFormat.format(updatedDate));
//     } else {
//       final dateFormat = DateFormat('d MMM y',
//           Localizations.localeOf(navigatorKey.currentContext!).languageCode);
//       buffer.write(dateFormat.format(updatedDate));
//     }
//     return buffer.toString();
//   }

//   static Radius radius(double value) => Radius.circular(value);
//   static String getUrlByType(String type) {
//     switch (type.toLowerCase()) {
//       case 'audio':
//         return '/asap/api/v1/asap/chat/load_audio_file/';
//       case 'video':
//         return '/asap/api/v1/asap/chat/load_video_file/';
//       case 'image':
//         return '/asap/api/v1/asap/chat/load_image_file/';
//       default:
//         return '/asap/api/v1/asap/chat/load_file/';
//     }
//   }

//   static List<String> splitString(String input) {
//     final List<String> parts =
//         input.replaceAll("{", "").replaceAll("}", "").split(",");

//     final List<String> elements = [];

//     for (final String part in parts) {
//       final List<String> keyValue = part.split(":");

//       final String value = keyValue[1].trim();

//       elements.add(value);
//     }

//     return elements;
//   }

//   static Future<Map<String, dynamic>> getDeviceData({
//     required int profileId,
//     required String password,
//     String deviceToken = "abcdefg",
//     String deviceBrand = "Xiaomi",
//     String deviceManufacturer = "Xiaomi Ltd.", //win registeredOwner
//     String deviceModel = "Xiaomi X1",
//     String deviceOsVersion =
//         "Android v0.1", // windows productName //linux name //mac hostname
//   }) async {
//     final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//     if (kIsWeb) {
//       final deviceInfo = await deviceInfoPlugin.webBrowserInfo;
//       return {
//         "profile_id": profileId,
//         "password": password,
//         "device_token": deviceInfo.browserName,
//         "device_brand": deviceInfo.productSub,
//         "device_manufacturer": deviceInfo.vendor,
//         "device_model": deviceInfo.hardwareConcurrency,
//         "device_os_version": deviceInfo.appVersion
//       };
//     } else if (Platform.isMacOS) {
//       final deviceInfo = await deviceInfoPlugin.macOsInfo;
//       log("INFO: ${deviceInfo.data}");
//       return {
//         "profile_id": profileId,
//         "password": password,
//         "device_token": deviceInfo.systemGUID.toString(),
//         "device_brand": deviceInfo.arch,
//         "device_manufacturer": deviceInfo.osRelease,
//         "device_model": deviceInfo.model,
//         "device_os_version": deviceInfo.hostName,
//       };
//     } else if (Platform.isWindows) {
//       final deviceInfo = await deviceInfoPlugin.windowsInfo;
//       log("INFO: ${deviceInfo.data}");
//       return {
//         "profile_id": profileId,
//         "password": password,
//         "device_token": deviceInfo.deviceId,
//         "device_brand": deviceInfo.productName,
//         "device_manufacturer": deviceInfo.editionId,
//         "device_model": deviceInfo.productType.toString(),
//         "device_os_version": deviceInfo.buildNumber.toString(),
//       };
//     } else if (Platform.isLinux) {
//       final deviceInfo = await deviceInfoPlugin.linuxInfo;
//       log("INFO: ${deviceInfo.data}");
//       return {
//         "profile_id": profileId,
//         "password": password,
//         "device_token": deviceInfo.machineId.toString(),
//         "device_brand": deviceInfo.version.toString(),
//         "device_manufacturer": deviceInfo.versionCodename.toString(),
//         "device_model": deviceInfo.versionId.toString(),
//         "device_os_version": deviceInfo.name,
//       };
//     } else {
//       return {
//         "profile_id": profileId,
//         "password": password,
//         "device_token": deviceToken,
//         "device_brand": deviceBrand,
//         "device_manufacturer": deviceManufacturer,
//         "device_model": deviceModel,
//         "device_os_version": deviceOsVersion
//       };
//     }
//   }

//   static Future<String> getAppInfo({required ProjectInfo info}) async {
//     final data = await getDeviceData(
//         profileId: int.parse(UserPref.getUserId), password: "");
//     final width = navigatorKey.currentState?.overlay?.context.width;
//     final height = navigatorKey.currentState?.overlay?.context.height;

//     final result =
//         "App Version: ${info.version} ${nameServer.name}\nDevice brand: ${data["device_brand"]}\nManufacturer: ${data["device_manufacturer"]}\nOS Version: ${data["device_os_version"]}\nDevice Model: ${data["device_model"]}\nSFERA ID: ${UserPref.getUserId}\nW\\H: $width\\$height";

//     return result;
//   }

//   static String getOnlineStatus(
//       OnlineUser? user, String? type, BuildContext context,
//       {bool isSettings = false}) {
//     if (user != null && type != null && type == "DIRECT") {
//       switch (user.onlineStatus) {
//         case OnlineStatus.isNothing:
//           final dateDiff =
//               DateTime.now().difference(user.time ?? DateTime.now());
//           if (dateDiff.inMinutes < 30) {
//             return context.localization.ap_userstatus_lastseen_recently;
//           } else if (dateDiff.inDays < 1 &&
//               DateTime.now().day == user.time!.day) {
//             final time =
//                 "${user.time!.hour.toString().padLeft(2, '0')}:${user.time!.minute.toString().padLeft(2, '0')}";
//             return context.localization.ap_userstatus_lastseen_at_time(time);
//           } else if (dateDiff.inDays < 2 &&
//               DateTime.now().day > user.time!.day) {
//             final time =
//                 "${user.time!.hour.toString().padLeft(2, '0')}:${user.time!.minute.toString().padLeft(2, '0')}";
//             return context.localization.ap_userstatus_lastseen_yesterday(time);
//           } else if (DateTime.now().year == user.time!.year) {
//             final date = DateFormat(
//                     'd MMMM', Localizations.localeOf(context).languageCode)
//                 .format(user.time!);
//             return context.localization.ap_userstatus_lastseen_at_date(date);
//           } else {
//             final date =
//                 "${user.time!.day.toString().padLeft(2, '0')}:${user.time!.month.toString().padLeft(2, '0')}:${user.time!.year.toString().padLeft(2, '0')}";
//             return context.localization.ap_userstatus_lastseen_at_date(date);
//           }

//         case OnlineStatus.isOnline:
//           return context.localization.online;
//         case OnlineStatus.isTyping:
//           return isSettings
//               ? context.localization.online
//               : context.localization.ap_status_action_chat_typing;
//       }
//     }
//     return '';
//   }

//   static String parseDigitsAfterUnderscore(String input) {
//     final parts = input.split('_');
//     if (parts.length > 1) {
//       final digits = parts[1].replaceAll(RegExp('[^0-9]'), '');
//       return digits;
//     }
//     return '';
//   }
// }
