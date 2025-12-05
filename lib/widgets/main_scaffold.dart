import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class MainScaffold extends StatelessWidget {
  final Widget body; // 页面主体内容

  const MainScaffold({
    super.key,
    required this.body,
  });

  // 判断当前页面是否需要显示底部菜单
  bool _shouldShowBottomNav(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name ?? '';
    // 登录页，注册页 不显示底部菜单
    return ![AppRoutes.login, AppRoutes.register].contains(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      // 仅需显示底部菜单时，渲染BottomNavigationBar
      bottomNavigationBar: _shouldShowBottomNav(context)
          ? BottomNavigationBar(
              currentIndex: 0,
              onTap: null,
              type: BottomNavigationBarType.fixed, // 适配多选项
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
                BottomNavigationBarItem(icon: Icon(Icons.shop), label: '产品'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
              ],
            )
          : null, // 隐藏时设为null（关键：避免留白）
    );
  }
}