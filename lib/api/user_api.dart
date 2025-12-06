import '../utils/http.dart';

/// 用户相关 API
class UserApi {
  /// 登录接口
  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    return await HttpUtil.post(
      '/api/user/login',
      data: {'username': username, 'password': password},
    );
  }

  /// 获取用户信息
  static Future<Map<String, dynamic>> getUserInfo() async {
    return await HttpUtil.get('/api/user/info');
  }

  // 测试
  static Future<Map<String, dynamic>> test() async {
    return await HttpUtil.get('/api/test');
  }
}
