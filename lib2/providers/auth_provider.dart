import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 登录状态模型（可扩展用户信息）
class UserModel {
  final String token;
  final String username;

  UserModel({required this.token, required this.username});
}

// 全局登录状态管理
class AuthProvider extends ChangeNotifier {
  UserModel? _user; // 当前登录用户（null 表示未登录）
  bool _isLoading = false; // 登录/登出加载状态

  UserModel? get user => _user;
  bool get isLogin => _user != null;
  bool get isLoading => _isLoading;

  // APP 启动时初始化登录状态（读取本地存储）
  Future<void> initAuth() async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('token');
    final username = sp.getString('username');
    if (token != null && username != null) {
      _user = UserModel(token: token, username: username);
    }
    notifyListeners();
  }

  // 登录方法（存储凭证到本地 + 更新状态）
  Future<void> login({
    required String username,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    // 模拟接口请求（替换为真实登录接口）
    await Future.delayed(const Duration(seconds: 5));
    final token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';

    // 存储到本地
    final sp = await SharedPreferences.getInstance();
    await sp.setString('token', token);
    await sp.setString('username', username);

    // 更新全局状态
    _user = UserModel(token: token, username: username);
    _isLoading = false;
    notifyListeners();
  }

  // 登出方法（清除本地凭证 + 重置状态）
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    // 清除本地存储
    final sp = await SharedPreferences.getInstance();
    await sp.remove('token');
    await sp.remove('username');

    // 重置状态
    _user = null;
    _isLoading = false;
    notifyListeners();
  }
}
