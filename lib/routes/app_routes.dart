import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home/index.dart';
import '../screens/product/product_detail_screen.dart';
import '../utils/auth_manager.dart';

class AppRoutes {
  // 路由名称
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String productDetail = '/productDetail';

  // 无需登录即可访问的路由列表
  static final List<String> unAuthRoutes = [login, register];

  /// 路由拦截器（核心：权限验证）
  static Future<String> getInitialRoute() async {
    final isLogin = await AuthManager.getLoginStatus();
    // 已登录：默认跳首页；未登录：默认跳登录页
    return isLogin ? home : login;
  }

  /// 通用路由跳转方法（带权限验证）
  static Future<void> pushNamed(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) async {
    final isLogin = await AuthManager.getLoginStatus();
    final isUnAuthRoute = unAuthRoutes.contains(routeName);

    // 未登录 + 访问需要权限的路由 → 跳登录页
    if (!isLogin && !isUnAuthRoute) {
      Navigator.pushReplacementNamed(context, login);
      return;
    }

    // 已登录 + 访问登录/注册页 → 跳首页
    if (isLogin && isUnAuthRoute) {
      Navigator.pushReplacementNamed(context, home);
      return;
    }

    // 正常跳转
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  // 路由映射
  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    home: (context) => const HomePage(),
    productDetail: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      return ProductDetailScreen(product: args['product']);
    },
  };
}
