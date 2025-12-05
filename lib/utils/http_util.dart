import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../routes/app_routes.dart';

class HttpUtil {
  static late Dio _dio;

  // 初始化 Dio
  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://your-api-domain.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // 添加请求拦截器：自动携带 token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final sp = await SharedPreferences.getInstance();
          final token = sp.getString('token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          // 401 错误：token 失效 → 触发登出
          if (error.response?.statusCode == 401) {
            // 获取全局 AuthProvider
            final context = navigatorKey.currentContext!;
            final authProvider = Provider.of<AuthProvider>(
              context,
              listen: false,
            );
            await authProvider.logout();
            // 跳转到登录页
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (route) => false,
            );
          }
          return handler.next(error);
        },
      ),
    );
  }

  // 封装 GET 请求
  static Future<Response> get(
    String path, {
    Map<String, dynamic>? params,
  }) async {
    return await _dio.get(path, queryParameters: params);
  }

  // 封装 POST 请求
  static Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }
}

// 全局导航 key（用于无上下文时跳转）
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
