import 'package:dio/dio.dart';

import '../utils/dio_client.dart';

final _dioClient = dioClient;

/// 用户相关 API
class UserApi {
  /// 登录接口
  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      return await _dioClient.post(
        '/user/login',
        data: {'username': username, 'password': password},
      );
    } on DioException catch (e) {
      // 可在此处针对特定错误码做处理（如登录失败、账号冻结等）
      // if (e.code == 401) {
      //   throw DioException(code: 401, msg: '用户名或密码错误');
      // }
      rethrow; // 其他错误抛给上层处理
    }
  }

  /// 获取用户信息
  static Future<Map<String, dynamic>> getUserInfo() async {
    return await _dioClient.get('/user/info');
  }
}
