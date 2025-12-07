import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_auth/api/user_api.dart';

class LoginPage extends StatefulWidget {
  final String? redirectRoute; // 登录成功后跳转的路由

  const LoginPage({super.key, this.redirectRoute});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 表单控制器
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // 密码是否可见
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 登录逻辑
  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      // 验证通过，执行登录请求
      String phone = _phoneController.text.trim();
      String password = _passwordController.text.trim();

      Map<String, dynamic> res = await UserApi.login(
        username: phone,
        password: password,
      );

      // TODO: 调用登录API
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("登录中...")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 透明状态栏
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        // 渐变背景
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF7E5F), Color(0xFFFF6A88)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                // 应用Logo和标题
                const SizedBox(height: 60),
                Image.asset(
                  "assets/gewara_logo.png", // 替换为实际Logo路径
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 16),
                const Text(
                  "格瓦拉 @演出",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // 表单区域
                const SizedBox(height: 80),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // 手机号输入框
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                        ],
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white24,
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          hintText: "请输入手机号",
                          hintStyle: const TextStyle(color: Colors.white54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.length != 11) {
                            return "请输入正确的手机号";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // 密码输入框
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white24,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(
                                () => _obscurePassword = !_obscurePassword,
                              );
                            },
                          ),
                          hintText: "请输入您的登录密码",
                          hintStyle: const TextStyle(color: Colors.white54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return "密码长度不能少于6位";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                // 登录按钮
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "登录",
                      style: TextStyle(
                        color: Color(0xFFFF6A88),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // 辅助链接
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // 跳转到注册页面
                      },
                      child: const Text(
                        "立即注册",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // 跳转到忘记密码页面
                      },
                      child: const Text(
                        "忘记密码",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),

                // 第三方登录
                const SizedBox(height: 60),
                const Text(
                  "第三方帐号登录",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 微信登录
                    IconButton(
                      icon: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xFF07C160),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.wechat,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      onPressed: () {
                        // 微信登录逻辑
                      },
                    ),
                    const SizedBox(width: 30),
                    // QQ登录
                    IconButton(
                      icon: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xFF12B7F5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.question_answer,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      onPressed: () {
                        // QQ登录逻辑
                      },
                    ),
                    const SizedBox(width: 30),
                    // 微博登录
                    IconButton(
                      icon: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF8C39),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.whatshot,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      onPressed: () {
                        // 微博登录逻辑
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
