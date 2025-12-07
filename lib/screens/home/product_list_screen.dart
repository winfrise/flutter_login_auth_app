import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../routes/app_routes.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late List<Product> _products;
  bool _isLoading = false;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    // 初始化产品数据
    _products = _generateProducts(1);
  }

  // 模拟生成产品数据
  List<Product> _generateProducts(int page) {
    return List.generate(10, (index) {
      final id = (page - 1) * 10 + index + 1;
      return Product(
        id: id,
        title: '产品 $id',
        description: '这是产品 $id 的详细描述，包含产品特性、使用说明等',
        imageUrl: 'https://picsum.photos/200/200?random=$id',
        price: 99.9 + id,
      );
    });
  }

  // 下拉刷新
  Future<void> _onRefresh() async {
    setState(() {
      _isLoading = true;
    });
    // 模拟网络请求
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _page = 1;
      _products = _generateProducts(1);
      _isLoading = false;
    });
  }

  // 上拉加载更多
  Future<void> _loadMore() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    // 模拟网络请求
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _page++;
      _products.addAll(_generateProducts(_page));
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemCount: _products.length + 1, // +1 用于加载更多的指示器
        itemBuilder: (context, index) {
          // 加载更多指示器
          if (index == _products.length) {
            return _buildLoadMoreIndicator();
          }

          // 产品列表项
          final product = _products[index];
          return ListTile(
            leading: Image.network(
              product.imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            title: Text(product.title),
            subtitle: Text(
              '¥${product.price.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.red),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // 跳转到产品详情页
              Navigator.pushNamed(
                context,
                AppRoutes.productDetail,
                arguments: {'product': product},
              );
            },
          );
        },
      ),
    );
  }

  // 加载更多指示器
  Widget _buildLoadMoreIndicator() {
    return _isLoading
        ? const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          )
        : InkWell(
            onTap: _loadMore,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: Text('点击加载更多')),
            ),
          );
  }
}
