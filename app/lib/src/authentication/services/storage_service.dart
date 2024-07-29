import 'package:shared_preferences/shared_preferences.dart';

abstract interface class StorageService {
  Future<bool> write(String key, String value);
  Future<String?> read(String key);
  Future<bool> remove(String key);
}

class SharedPreferencesService implements StorageService {
  final _preferencesFuture = SharedPreferences.getInstance();

  @override
  Future<bool> write(String key, String value) async {
    final preferences = await _preferencesFuture;

    return preferences.setString(key, value);
  }

  @override
  Future<String?> read(String key) async {
    final preferences = await _preferencesFuture;

    if (!preferences.containsKey(key)) {
      return null;
    }

    return preferences.getString(key);
  }

  @override
  Future<bool> remove(String key) async {
    final preferences = await _preferencesFuture;

    if (!preferences.containsKey(key)) {
      return false;
    }

    return preferences.remove(key);
  }
}

enum StorageServiceKeys {
  username;

  String get value {
    return name;
  }
}
