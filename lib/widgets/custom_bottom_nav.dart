import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '主页'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: '产品'),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: '消息'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
      ],
    );
  }
}
