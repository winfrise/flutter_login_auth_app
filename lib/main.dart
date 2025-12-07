import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/index.dart';
import 'utils/auth_manager.dart';

void main() async {
  // 初始化Flutter绑定（异步操作前必须加）
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化登录状态缓存（APP启动时一次性加载）
  await AuthManager.initCache();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/', // 初始路由（首页）
      routes: AppRoutes.routes,
      // // 关键：配置动态路由生成器 （路由拦截 + 权限校验）
      onGenerateRoute: (settings) {
        final routeName = settings.name ?? AppRoutes.login;
        final isUnAuthRoute = AppRoutes.unAuthRoutes.contains(routeName);

        // 同步校验：未登录 + 访问受保护路由 → 直接返回登录页
        if (!AuthManager.isLoginSync && !isUnAuthRoute) {
          return MaterialPageRoute(builder: (context) => const LoginScreen());
        }

        // 同步校验：已登录 + 访问登录/注册页 → 直接返回首页
        if (AuthManager.isLoginSync && isUnAuthRoute) {
          return MaterialPageRoute(builder: (context) => const HomePage());
        }

        // 正常路由
        return MaterialPageRoute(
          builder: (context) => AppRoutes.routes[routeName]!(context),
          settings: settings,
        );
      },
      // 防止未知路由绕过校验
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) =>
              AuthManager.isLoginSync ? const HomePage() : const LoginScreen(),
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
