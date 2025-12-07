import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../utils/auth_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _pwdController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // 保存登录状态 + 手机号
      AuthManager.saveLoginStatus(true).then((_) {
        AuthManager.saveLoginPhone(_phoneController.text).then((_) {
          // 登录成功跳首页
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('登录')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: '手机号',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (v) => v!.isEmpty ? '请输入手机号' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pwdController,
                decoration: const InputDecoration(
                  labelText: '密码',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                obscureText: true,
                validator: (v) => v!.length < 6 ? '密码不少于6位' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('登录', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
                child: const Text('还没有账号？去注册'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
