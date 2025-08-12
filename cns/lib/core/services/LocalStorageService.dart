import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _kBranch = 'parent_branch';
  static const _kYear = 'parent_year';
  static const _kToken = 'parent_fcm_token';

  Future<void> saveParentData({
    required String branch,
    required String year,
    required String fcmToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kBranch, branch);
    await prefs.setString(_kYear, year);
    await prefs.setString(_kToken, fcmToken);
  }

  Future<Map<String, String>?> getParentData() async {
    final prefs = await SharedPreferences.getInstance();
    final branch = prefs.getString(_kBranch);
    final year = prefs.getString(_kYear);
    final token = prefs.getString(_kToken);
    if (branch != null && year != null && token != null) {
      return {'branch': branch, 'year': year, 'token': token};
    }
    return null;
  }

  Future<void> clearParentData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kBranch);
    await prefs.remove(_kYear);
    await prefs.remove(_kToken);
  }
}
