import 'package:shared_preferences/shared_preferences.dart';

// import 'package:encrypt/encrypt.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// import '../ui/pages/openvidu/widgets/settings_call.dart';

class UserPref {
  static late SharedPreferences _prefs;
  factory UserPref() => UserPref._internal();
  UserPref._internal();

  // static bool get firstRun => _prefs.getBool("firstRun") ?? true;
  // static set firstRun(bool first) => _prefs.setBool("firstRun", first);

  static Future<void> init() async =>
      _prefs = await SharedPreferences.getInstance();

  // static set filePickSize(bool isLarge) => _prefs.setBool('isLarge', isLarge);
  // static bool get filePickSize => _prefs.getBool('isLarge') ?? false;

  // static set supportedFileType(bool isSupported) =>
  //     _prefs.setBool('isSupported', isSupported);
  // static bool get supportedFileType => _prefs.getBool('isSupported') ?? true;

  // static set isLight(bool isLight) => _prefs.setBool('isLight', isLight);
  // static bool get isLight => _prefs.getBool('isLight') ?? false;

  // static set isDialog(bool isDialog) => _prefs.setBool('isDialog', isDialog);
  // static bool get isDialog => _prefs.getBool('isDialog') ?? false;

  // static set isNotificationsOn(bool isNotificationsOn) =>
  //     _prefs.setBool('isNotificationsOn', isNotificationsOn);
  // static bool get isNotificationsOn =>
  //     _prefs.getBool('isNotificationsOn') ?? true;

  // static String get lastEvent => _prefs.getString('lastEvent') ?? '';
  // static set lastEvent(String info) => _prefs.setString('lastEvent', info);

  // static set notificationStatus(bool notificationStatus) =>
  //     _prefs.setBool('notificationStatus', notificationStatus);
  // static bool get notificationStatus =>
  //     _prefs.getBool('notificationStatus') ?? false;

  // static set windowInfo(String info) => _prefs.setString('windowInfo', info);
  // static String get windowInfo => _prefs.getString('windowInfo') ?? '';

  // static set setLocale(String locale) => _prefs.setString('locale', locale);
  // static String? get getLocale => _prefs.getString('locale');
  // static Future<void> removeLocale() async => _prefs.remove('locale');

  // static set onWindowCloseStatus(String systemTrayStatus) =>
  //     _prefs.setString('systemTrayStatus', systemTrayStatus);
  // static bool get isRemember => _prefs.getBool('isRemember') ?? false;
  // static set isRemember(bool val) => _prefs.setBool('isRemember', val);
  // static String get onWindowCloseStatus =>
  //     _prefs.getString('systemTrayStatus') ?? '';

  // static set isTrayOnStatus(String isTrayOnStatus) =>
  //     _prefs.setString('isTrayOnStatus', isTrayOnStatus);

  // static String get isTrayOnStatus =>
  //     _prefs.getString('isTrayOnStatus') ??
  //     IsTrayOnStatusExtention.toValueString(IsTrayOnStatus.alwaysDefault);

  static Future close() => _prefs.clear();

  static set setUserUid(String uid) => _prefs.setString('uid', uid);
  static String get getUserUid => _prefs.getString('uid') ?? '';

  // static set setSendBirdToken(String token) =>
  //     _prefs.setString('sendBirdToken', token);
  // static String get getSendBirdToken => _prefs.getString('sendBirdToken') ?? '';
  // static set setToken(String token) =>
  // _prefs.setString('token', _encryptData(token));
  static Future remove() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.remove('isDark');
    // await prefs.remove('locale');
    await prefs.remove('uid');
    // await prefs.remove('token');
  }
  // static Future removeTray() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('systemTrayStatus');

  // }
  // static set voiceMode(String key) => _prefs.setString('voiceMode', key);
  // static String get voiceMode => Platform.isMacOS
  //     ? VoiceMode.isDefault.name
  //     : _prefs.getString('voiceMode') ?? VoiceMode.isDefault.name;
  // static set walkieTalkie(int key) => _prefs.setInt('walkieTalkie', key);
  // static int get walkieTalkie =>
  //     Platform.isMacOS ? 32 : _prefs.getInt('walkieTalkie') ?? 32;

  // static String? get getToken => _decryptData(_prefs.getString('token') ?? '');

  // static String? get getProjectInfo => _prefs.getString('projectInfo');
  // static set setProjectInfo(String info) =>
  // _prefs.setString('projectInfo', info);
  // static set appVerison(String version) =>
  //     _prefs.setString('appVerison', version);
  // static String get appVerison => _prefs.getString('appVerison') ?? '';
  // static set serverVerison(String version) =>
  //     _prefs.setString('serverVerison', version);
  // static String get serverVerison => _prefs.getString('serverVerison') ?? '';
  // static String _makeKey() {
  //   String key = '';
  //   final text = _prefs.getString('id');
  //   if (text != null && text != '') {
  //     if (text.length < 32) {
  //       final int dif = 32 - text.length;
  //       key = text;
  //       for (int i = 0; i < dif; i++) {
  //         key += key[i];
  //       }
  //     } else {
  //       for (int i = 0; i < 32; i++) {
  //         key += text[i];
  //       }
  //     }
  //   }
  //   return key;
  // }

  // static String _encryptData(String text) {
  //   if (text == '') return '';
  //   final iv = IV.fromLength(16);
  //   final key = Key.fromBase64(_makeKey());
  //   final e = Encrypter(AES(key, mode: AESMode.cbc));
  //   final encrypted = e.encrypt(text, iv: iv);
  //   return encrypted.base64;
  // }

  // static String _decryptData(String text) {
  //   if (text == '') return '';
  //   final iv = IV.fromLength(16);
  //   final key = Key.fromBase64(_makeKey());
  //   final e = Encrypter(AES(key, mode: AESMode.cbc));
  //   final decrypted = e.decrypt(Encrypted.fromBase64(text), iv: iv);
  //   return decrypted;
  // }

  // static void setSessionId(String sessionId) =>
  //     _prefs.setString('sessionId', sessionId);
  // static String getSessionId() => _prefs.getString('sessionId') ?? '';
}
