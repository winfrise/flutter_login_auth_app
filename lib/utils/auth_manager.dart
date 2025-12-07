import 'package:shared_preferences/shared_preferences.dart';

/// 登录状态管理工具类（同步+异步双重校验）
class AuthManager {
  // 存储key
  static const String _loginStatusKey = 'is_login';
  static const String _phoneKey = 'login_phone';

  // 内存缓存（同步获取，解决异步延迟问题）
  static bool? _isLoginCache;
  static String? _phoneCache;

  /// 初始化缓存（APP启动时调用，只调用一次）
  static Future<void> initCache() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoginCache = prefs.getBool(_loginStatusKey) ?? false;
    _phoneCache = prefs.getString(_phoneKey);
  }

  /// 同步获取登录状态（优先内存缓存）
  static bool get isLoginSync {
    return _isLoginCache ?? false;
  }

  /// 异步获取登录状态（刷新缓存）
  static Future<bool> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final status = prefs.getBool(_loginStatusKey) ?? false;
    _isLoginCache = status; // 更新内存缓存
    return status;
  }

  /// 保存登录状态（同步+异步）
  static Future<void> saveLoginStatus(bool isLogin) async {
    _isLoginCache = isLogin; // 先更新内存（同步）
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginStatusKey, isLogin); // 再持久化
  }

  /// 保存登录手机号
  static Future<void> saveLoginPhone(String phone) async {
    _phoneCache = phone;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_phoneKey, phone);
  }

  /// 同步获取手机号
  static String? get phoneSync {
    return _phoneCache;
  }

  /// 异步获取手机号
  static Future<String?> getLoginPhone() async {
    final prefs = await SharedPreferences.getInstance();
    final phone = prefs.getString(_phoneKey);
    _phoneCache = phone;
    return phone;
  }

  /// 退出登录（清除所有缓存）
  static Future<void> logout() async {
    _isLoginCache = false; // 同步清空内存
    _phoneCache = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loginStatusKey);
    await prefs.remove(_phoneKey);
  }
}
