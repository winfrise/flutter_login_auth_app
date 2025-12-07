import 'package:flutter/material.dart';
import '../widgets/goods_item.dart';
import '../widgets/category_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 底部菜单选中索引
  int _currentTabIndex = 0;

  // 底部菜单配置
  final List<BottomNavigationBarItem> _tabItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: '首页',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search_outlined),
      activeIcon: Icon(Icons.search),
      label: '分类',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add_circle_outline),
      activeIcon: Icon(Icons.add_circle),
      label: '发布',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.message_outlined),
      activeIcon: Icon(Icons.message),
      label: '消息',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outlined),
      activeIcon: Icon(Icons.person),
      label: '我的',
    ),
  ];

  // 模拟商品数据
  final List<Map<String, String>> _goodsList = [
    {
      'image':
          'https://img1.baidu.com/it/u=1234567890,1234567890&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
      'title': '99新iPhone 15 Pro Max 256G 原色钛金属 无拆无修 电池健康98%',
      'price': '¥6800',
      'location': '北京朝阳',
      'time': '1小时前',
    },
    {
      'image':
          'https://img2.baidu.com/it/u=0123456789,0123456789&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
      'title': '小米笔记本Pro 2024款 16G+1T 锐龙7 成色新 带原装充电器',
      'price': '¥4200',
      'location': '上海浦东',
      'time': '2小时前',
    },
    {
      'image':
          'https://img3.baidu.com/it/u=9876543210,9876543210&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
      'title': 'Nike Air Jordan 1 黑曜石 43码 穿了3次 几乎全新 带鞋盒',
      'price': '¥1800',
      'location': '广州天河',
      'time': '3小时前',
    },
    {
      'image':
          'https://img0.baidu.com/it/u=1122334455,1122334455&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
      'title': '索尼WH-1000XM5 头戴式降噪耳机 买了2个月 几乎没用 全套配件',
      'price': '¥1500',
      'location': '深圳南山',
      'time': '4小时前',
    },
    {
      'image':
          'https://img4.baidu.com/it/u=5566778899,5566778899&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
      'title': '任天堂Switch OLED 港版 续航版 带塞尔达+马里奥 几乎全新',
      'price': '¥1900',
      'location': '成都武侯',
      'time': '5小时前',
    },
  ];

  // 分类数据
  final List<Map<String, String>> _categoryList = [
    {'icon': 'home', 'title': '家居'},
    {'icon': 'phone', 'title': '手机'},
    {'icon': 'computer', 'title': '数码'},
    {'icon': 'clothes', 'title': '服饰'},
    {'icon': 'book', 'title': '图书'},
    {'icon': 'car', 'title': '二手车'},
    {'icon': 'game', 'title': '游戏'},
    {'icon': 'more', 'title': '更多'},
  ];

  // 切换底部菜单
  void _onTabChanged(int index) {
    setState(() {
      _currentTabIndex = index;
      // 发布按钮单独处理（示例）
      if (index == 2) {
        _showPublishDialog();
      }
    });
  }

  // 发布按钮弹窗
  void _showPublishDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('发布商品'),
        content: const Text('选择发布类型'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('发闲置'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('发鱼塘'),
          ),
        ],
      ),
    );
    // 重置底部菜单为首页（避免选中发布按钮）
    setState(() {
      _currentTabIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // 首页内容
      body: _currentTabIndex == 0
          ? _buildHomeContent()
          : _buildOtherTabContent(),
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: _onTabChanged,
        items: _tabItems,
        type: BottomNavigationBarType.fixed, // 固定5个选项
        selectedItemColor: const Color(0xFFFC6721), // 闲鱼橙色
        unselectedItemColor: Colors.grey.shade600,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 8,
        backgroundColor: Colors.white,
      ),
    );
  }

  // 首页内容构建
  Widget _buildHomeContent() {
    return ListView(
      physics: const BouncingScrollPhysics(), // 仿iOS弹性滚动
      children: [
        // 顶部搜索栏
        Container(
          color: const Color(0xFFFC6721),
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: const Row(
                        children: [
                          SizedBox(width: 10),
                          Icon(Icons.search, size: 18, color: Colors.grey),
                          SizedBox(width: 5),
                          Text(
                            '搜索你想要的宝贝',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.camera_alt, color: Colors.white, size: 22),
                ],
              ),
            ],
          ),
        ),

        // 分类入口
        Container(
          height: 100,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 8,
            children: _categoryList.map((item) {
              return CategoryItem(icon: item['icon']!, title: item['title']!);
            }).toList(),
          ),
        ),

        const SizedBox(height: 5),

        // 推荐商品列表
        Column(
          children: _goodsList.map((goods) {
            return GoodsItem(
              imageUrl: goods['image']!,
              title: goods['title']!,
              price: goods['price']!,
              location: goods['location']!,
              time: goods['time']!,
            );
          }).toList(),
        ),
      ],
    );
  }

  // 其他底部菜单页面（占位）
  Widget _buildOtherTabContent() {
    String title = '';
    switch (_currentTabIndex) {
      case 1:
        title = '分类';
        break;
      case 2:
        title = '发布';
        break;
      case 3:
        title = '消息';
        break;
      case 4:
        title = '我的';
        break;
    }
    return Center(
      child: Text(
        '$title页面',
        style: const TextStyle(fontSize: 20, color: Colors.grey),
      ),
    );
  }
}
