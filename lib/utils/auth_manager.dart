import 'package:shared_preferences/shared_preferences.dart';

/// 登录状态管理工具类
class AuthManager {
  // 存储登录状态的key
  static const String _loginStatusKey = 'is_login';
  // 存储手机号的key
  static const String _phoneKey = 'login_phone';

  /// 保存登录状态
  static Future<void> saveLoginStatus(bool isLogin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginStatusKey, isLogin);
  }

  /// 获取登录状态
  static Future<bool> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loginStatusKey) ?? false;
  }

  /// 保存登录手机号
  static Future<void> saveLoginPhone(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_phoneKey, phone);
  }

  /// 获取登录手机号
  static Future<String?> getLoginPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_phoneKey);
  }

  /// 退出登录（清除登录状态和手机号）
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loginStatusKey);
    await prefs.remove(_phoneKey);
  }
}
