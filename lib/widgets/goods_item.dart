import 'package:flutter/material.dart';

class GoodsItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String location;
  final String time;

  const GoodsItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.location,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 2,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 商品图片
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              // 占位图
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey.shade200,
                  child: const Center(child: CircularProgressIndicator(strokeWidth: 1)),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          // 商品信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 标题
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, height: 1.2),
                ),
                const SizedBox(height: 8),
                // 价格
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // 位置+时间
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      location,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                    Text(
                      time,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}