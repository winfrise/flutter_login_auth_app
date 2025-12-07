// 路由常量
class AppRoutes {
  // 公开页面（无需登录）
  static const login = '/login';
  static const splash = '/splash';
  static const register = '/register';

  // 需登录页面
  static const home = '/home';
  static const profile = '/profile';
  static const settings = '/settings';

  // 判断页面是否需要登录
  static bool needAuth(String routeName) {
    return [home, profile, settings].contains(routeName);
  }
}
