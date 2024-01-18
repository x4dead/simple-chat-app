class HelperFunction {
  static Future<void> updateList<T>(
      Set<T>? list, Future<void> Function() load) async {
    return list == null || list.isEmpty ? await load() : null;
  }
}
