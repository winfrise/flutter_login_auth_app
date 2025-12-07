import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _pwdController = TextEditingController();
  final _confirmPwdController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _pwdController.dispose();
    _confirmPwdController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      // 模拟注册成功，返回登录页
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('注册成功，请登录')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('注册')),
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
                  labelText: '设置密码',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (v) => v!.length < 6 ? '密码不少于6位' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPwdController,
                decoration: const InputDecoration(
                  labelText: '确认密码',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (v) {
                  if (v != _pwdController.text) {
                    return '两次密码不一致';
                  }
                  return v!.isEmpty ? '请确认密码' : null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('注册', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('已有账号？去登录'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
