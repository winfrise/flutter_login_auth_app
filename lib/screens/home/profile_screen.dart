import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../routes/app_routes.dart';
import '../../utils/auth_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // 模拟用户信息（实际可从接口/本地存储获取）
  late UserInfo _userInfo;

  @override
  void initState() {
    super.initState();
    // 从本地获取登录手机号
    _loadUserInfo();
  }

  /// 加载用户信息
  Future<void> _loadUserInfo() async {
    final phone = await AuthManager.getLoginPhone();
    if (phone != null && mounted) {
      setState(() {
        _userInfo = UserInfo(phone: phone);
      });
    }
  }

  /// 退出登录逻辑
  Future<void> _logout() async {
    // 显示确认弹窗
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认退出'),
        content: const Text('是否确定退出当前账号？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              // 关闭弹窗
              Navigator.pop(context);
              // 清除登录状态
              await AuthManager.logout();
              // 跳登录页
              if (mounted) {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('已成功退出登录')));
              }
            },
            child: const Text('退出', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // 功能列表项组件
  Widget _buildFunctionItem({
    required IconData icon,
    required String title,
    String? subTitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700], size: 24),
      title: Text(title),
      subtitle: subTitle != null ? Text(subTitle) : null,
      trailing:
          trailing ??
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
      dense: true,
    );
  }

  // 分割线
  Widget _buildDivider() {
    return const Divider(
      height: 0.5,
      indent: 16,
      endIndent: 16,
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // 顶部用户信息卡片（仿微信）
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            child: Column(
              children: [
                // 头像 + 昵称 + 手机号
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    // 头像
                    ClipOval(
                      child: Image.network(
                        _userInfo.avatar,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 15),
                    // 用户信息
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userInfo.nickname,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _userInfo.phone,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // 箭头
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 第一组功能列表
          Container(
            color: Colors.white,
            child: Column(
              children: [
                _buildFunctionItem(
                  icon: Icons.shopping_cart,
                  title: '我的订单',
                  onTap: () => ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('我的订单页面开发中'))),
                ),
                _buildDivider(),
                _buildFunctionItem(
                  icon: Icons.favorite,
                  title: '我的收藏',
                  onTap: () => ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('我的收藏页面开发中'))),
                ),
                _buildDivider(),
                _buildFunctionItem(
                  icon: Icons.settings_accessibility,
                  title: '地址管理',
                  onTap: () => ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('地址管理页面开发中'))),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 第二组功能列表
          Container(
            color: Colors.white,
            child: Column(
              children: [
                _buildFunctionItem(
                  icon: Icons.settings,
                  title: '设置',
                  onTap: () => ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('设置页面开发中'))),
                ),
                _buildDivider(),
                _buildFunctionItem(
                  icon: Icons.help_outline,
                  title: '帮助与反馈',
                  onTap: () => ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('帮助与反馈页面开发中'))),
                ),
                _buildDivider(),
                _buildFunctionItem(
                  icon: Icons.info_outline,
                  title: '关于我们',
                  onTap: () => ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('关于我们页面开发中'))),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 退出登录按钮（独立模块）
          Container(
            color: Colors.white,
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red, size: 24),
              title: const Text('退出登录', style: TextStyle(color: Colors.red)),
              onTap: _logout,
            ),
          ),
        ],
      ),
    );
  }
}
