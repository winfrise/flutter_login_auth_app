// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  // 轮播图数据
  // final List<String> _bannerImages = [
  //   'https://picsum.photos/800/300?random=1',
  //   'https://picsum.photos/800/300?random=2',
  //   'https://picsum.photos/800/300?random=3',
  // ];

  // 分类数据
  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.phone_android, 'title': '手机数码', 'color': Colors.blue},
    {'icon': Icons.laptop, 'title': '电脑办公', 'color': Colors.green},
    {'icon': Icons.home, 'title': '家居用品', 'color': Colors.orange},
    {'icon': Icons.favorite, 'title': '美妆护肤', 'color': Colors.pink},
    {'icon': Icons.shopping_bag, 'title': '服饰箱包', 'color': Colors.purple},
    {'icon': Icons.fastfood, 'title': '食品生鲜', 'color': Colors.amber},
  ];

  // 推荐产品数据
  final List<Map<String, dynamic>> _recommendProducts = [
    {
      'id': 1,
      'title': '爆款智能手机',
      'image': 'https://picsum.photos/200/200?random=10',
      'price': 2999.0,
      'originalPrice': 3299.0,
    },
    {
      'id': 2,
      'title': '轻薄笔记本电脑',
      'image': 'https://picsum.photos/200/200?random=11',
      'price': 4999.0,
      'originalPrice': 5499.0,
    },
    {
      'id': 3,
      'title': '无线蓝牙耳机',
      'image': 'https://picsum.photos/200/200?random=12',
      'price': 199.0,
      'originalPrice': 299.0,
    },
    {
      'id': 4,
      'title': '智能手表',
      'image': 'https://picsum.photos/200/200?random=13',
      'price': 899.0,
      'originalPrice': 999.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 顶部搜索栏
            _buildSearchBar(context),
            // 轮播图
            // _buildBanner(),
            // 分类入口
            _buildCategories(),
            // 推荐产品区
            _buildRecommendProducts(context),
          ],
        ),
      ),
    );
  }

  // 顶部搜索栏
  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 12),
                  Icon(Icons.search, color: Colors.grey, size: 20),
                  SizedBox(width: 8),
                  Text(
                    '搜索商品/品牌',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.shopping_cart_outlined, size: 24),
        ],
      ),
    );
  }

  // 轮播图
  // Widget _buildBanner() {
  //   return CarouselSlider(
  //     options: CarouselOptions(
  //       height: 150,
  //       autoPlay: true,
  //       autoPlayInterval: const Duration(seconds: 3),
  //       autoPlayAnimationDuration: const Duration(milliseconds: 800),
  //       viewportFraction: 1.0,
  //       indicatorBgPadding: 8.0,
  //     ),
  //     items: _bannerImages.map((imageUrl) {
  //       return Builder(
  //         builder: (BuildContext context) {
  //           return Container(
  //             width: MediaQuery.of(context).size.width,
  //             margin: const EdgeInsets.symmetric(vertical: 8),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(8),
  //               image: DecorationImage(
  //                 image: NetworkImage(imageUrl),
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     }).toList(),
  //   );
  // }

  // 分类入口
  Widget _buildCategories() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '分类专区',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: _categories.map((category) {
              return Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: category['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Icon(
                      category['icon'],
                      color: category['color'],
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(category['title'], style: const TextStyle(fontSize: 14)),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // 推荐产品区
  Widget _buildRecommendProducts(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '猜你喜欢',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  // 跳转到产品列表页
                  AppRoutes.pushNamed(context, AppRoutes.home);
                  // 切换到产品Tab（需要修改HomeScreen的currentIndex）
                  // 这里简化处理，实际可通过回调/状态管理实现
                },
                child: const Text(
                  '查看更多',
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _recommendProducts.length,
              itemBuilder: (context, index) {
                final product = _recommendProducts[index];
                return Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 产品图片
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(product['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // 产品标题
                      Text(
                        product['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      // 价格
                      Text(
                        '¥${product['price'].toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      // 原价（划线）
                      Text(
                        '¥${product['originalPrice'].toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
