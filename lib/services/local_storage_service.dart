import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _keyEmail = 'local_email';
  static const String _keyPassword = 'local_password';

  Future<void> saveCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyPassword, password);
  }

  Future<Map<String, String?>> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'email': prefs.getString(_keyEmail),
      'password': prefs.getString(_keyPassword),
    };
  }
}
