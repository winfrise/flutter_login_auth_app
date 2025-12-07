import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../routes/app_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user!;

    return Scaffold(
      appBar: AppBar(title: const Text('个人中心')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('用户名：${user.username}'),
            Text('Token：${user.token}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await authProvider.logout();
                // 登出后跳转到登录页
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (route) => false,
                );
              },
              child: const Text('退出登录'),
            ),
          ],
        ),
      ),
    );
  }
}
