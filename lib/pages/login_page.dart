import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../routes/app_routes.dart' show AppRoutes;

class LoginPage extends StatefulWidget {
  final String? redirectRoute; // 登录成功后跳转的路由

  const LoginPage({super.key, this.redirectRoute});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('登录')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _usernameCtrl,
              decoration: const InputDecoration(hintText: '用户名'),
            ),
            TextField(
              controller: _passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(hintText: '密码'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: authProvider.isLoading
                  ? null
                  : () async {
                      // 调用登录方法
                      await authProvider.login(
                        username: _usernameCtrl.text,
                        password: _passwordCtrl.text,
                      );
                      // 登录成功 → 跳转到目标路由（默认首页）
                      if (authProvider.isLogin) {
                        Navigator.pushReplacementNamed(
                          context,
                          widget.redirectRoute ?? AppRoutes.home,
                        );
                      }
                    },
              child: authProvider.isLoading
                  ? const CircularProgressIndicator(value: 20)
                  : const Text('登录'),
            ),
          ],
        ),
      ),
    );
  }
}
