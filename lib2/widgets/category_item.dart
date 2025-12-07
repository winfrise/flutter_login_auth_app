import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String icon;
  final String title;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 分类图标（使用FontAwesome更还原，这里用Material图标替代）
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Icon(
              icon == 'home' ? Icons.home :
              icon == 'phone' ? Icons.phone_android :
              icon == 'computer' ? Icons.computer :
              icon == 'clothes' ? Icons.checkroom :
              icon == 'book' ? Icons.book :
              icon == 'car' ? Icons.car_rental :
              icon == 'game' ? Icons.gamepad :
              Icons.more_horiz,
              size: 22,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}