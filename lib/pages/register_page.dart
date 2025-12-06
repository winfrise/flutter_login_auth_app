import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_auth/utils/http.dart';

import '../api/user_api.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /// 登录按钮点击事件
  Future<void> _login() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请输入用户名和密码')));
      return;
    }

    Map<String, dynamic> res = await HttpUtil.get('/api/test');
    print(res);

    // await UserApi.getUserInfo();

    // 调用登录接口
    // Map<String, dynamic> userData = await UserApi.login(
    //   username: username,
    //   password: password,
    // );

    // print(userData);

    // 登录成功，处理逻辑（如保存 token、跳转到首页）
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('登录成功')));
    // Navigator.pop(context); // 关闭加载弹窗
    // Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('登录（注册页）')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(hintText: '用户名111'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: '密码111'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(onPressed: _login, child: const Text('登录')),
          ],
        ),
      ),
    );
  }
}
