import 'package:flutter/material.dart';

import '../../widgets/custom_bottom_nav.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'message_screen.dart';
import 'product_list_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // 底部导航对应的页面
  final List<Widget> _pages = const [
    HomeScreen(),
    ProductListScreen(),
    MessageScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(['主页', '产品', '消息', '我的'][_currentIndex])),
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
