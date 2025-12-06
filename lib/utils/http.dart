import 'dart:convert';
import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

// 全局 Dio 实例
late Dio dio;

// 初始化 HTTP 配置（根据环境切换 Mock/真实接口）
Future<void> initHttp() async {
  // 初始化 Dio 基础配置
  dio = Dio();
  // ..options.baseUrl = dotenv.env['API_BASE_URL']!
  // ..options.connectTimeout = const Duration(milliseconds: 5000)
  // ..options.receiveTimeout = const Duration(milliseconds: 3000)
  // ..options.responseType = ResponseType.json
  // ..options.headers = {"Content-Type": "application/json;charset=utf-8"};

  // 开发环境：配置 Mock 数据
  // if (dotenv.env['USE_MOCK'] == true) {
  print('初始化mock');
  final mockAdapter = DioAdapter(dio: dio);
  // 模拟登录接口（POST /user/login）
  mockAdapter.onPost(
    '/api/user/login',
    (server) => server.reply(
      200,
      {
        "code": 200,
        "msg": "登录成功",
        "data": {"token": "mock_token_123456"},
      },
      delay: const Duration(milliseconds: 100), // 模拟网络延迟
    ),
    data: {'username': 'admin', 'password': '123456'},
  );

  // 获取用户信息接口
  mockAdapter.onGet(
    '/api/user/info',
    (server) => server.reply(
      200,
      {
        'code': '000',
        'message': 'UserInfo Success',
        'data': {
          "userId": "100002",
          "username": "zhangsan",
          "nickname": "张三",
          "status": 1,
          "avatar": "https://example.com/avatar/1008611.png",
          "gender": 1,
          "phone": "138****8000",
          "email": "zhang***@example.com",
          "birthday": "1990-01-01",
        },
      },
      delay: const Duration(milliseconds: 100), // 模拟网络延迟
    ),
  );

  mockAdapter.onGet(
    '/api/test',
    (server) => server.reply(
      200,
      {'message': 'Success!'},
      // Reply would wait for one-sec before returning data.
      delay: const Duration(seconds: 1),
    ),
  );

  dio.httpClientAdapter = mockAdapter;
  // }
  // 生产环境：无 Mock，直接使用真实接口（无需额外配置）
}

// 核心请求工具类
class HttpUtil {
  // POST 请求
  static Future<T> post<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    final response = await dio.post(
      path,
      data: data != null ? data : null,
      queryParameters: params,
      options: options,
    );
    return response.data as T;
  }

  // GET 请求
  static Future<T> get<T>(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    final response = await dio.get(
      path,
      queryParameters: params,
      options: options,
    );
    return response.data as T;
  }
}
