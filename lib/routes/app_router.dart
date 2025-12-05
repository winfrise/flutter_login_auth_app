import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/splash_page.dart';
import '../pages/login_page.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';

import '../providers/auth_provider.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final routeName = settings.name ?? AppRoutes.home;

    print('routeName:' + routeName);

    return MaterialPageRoute(
      builder: (context) {
        // 1. 检查页面是否需要登录
        final needAuth = AppRoutes.needAuth(routeName);

        // 若设置 listen: true（默认）：Widget 会监听该 Provider 的状态变化，状态更新时自动重建；
        // 若设置 listen: false：仅获取实例，不监听变化，Widget 不会重建。
        final authProvider = Provider.of<AuthProvider>(context, listen: true);

        print('needAuth:' + needAuth.toString());
        print('isLogin:' + authProvider.isLoading.toString());

        // 2. 未登录且页面需要登录 → 跳转到登录页（携带原路由，登录后返回）
        if (needAuth && !authProvider.isLogin) {
          return LoginPage(
            redirectRoute: routeName, // 登录成功后跳转的目标路由
          );
        }

        // 3. 路由分发
        switch (routeName) {
          case AppRoutes.splash:
            return const SplashPage();
          case AppRoutes.login:
            return LoginPage(redirectRoute: settings.arguments as String?);
          case AppRoutes.home:
            return const HomePage();
          case AppRoutes.profile:
            return const ProfilePage();
          default:
            return const Scaffold(body: Center(child: Text('404 Page')));
        }
      },
      settings: settings,
    );
  }
}
