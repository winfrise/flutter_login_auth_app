import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'routes/app_router.dart';
import 'routes/app_routes.dart';
import 'utils/http_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化网络请求
  HttpUtil.init();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider()..initAuth(), // 启动时初始化登录状态
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '权限管理示例',
      navigatorKey: navigatorKey, // 全局导航 key
      initialRoute: AppRoutes.home, // 启动页
      onGenerateRoute: AppRouter.generateRoute, // 自定义路由生成器
      debugShowCheckedModeBanner: false,
    );
  }
}
