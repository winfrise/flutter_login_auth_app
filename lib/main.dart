import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'routes/app_router.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 2. 加载环境变量（默认加载 .env 文件）
  // 若要加载指定环境（如生产环境）：await dotenv.load(fileName: ".env.prod");
  await dotenv.load(fileName: ".env.dev");

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider()..initAuth(), // 启动时初始化登录状态
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '权限管理示例',

      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: const Color(0xFFFC6721), // 橙色
        scaffoldBackgroundColor: Colors.grey.shade100,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color(0xFFFC6721),
        ),
      ),
      initialRoute: AppRoutes.home, // 启动页
      // home: HomePage(), // initialRoute 和 home只能存在一个
      onGenerateRoute: AppRouter.generateRoute, // 自定义路由生成器
      debugShowCheckedModeBanner: false, // 隐藏调试标签
    );
  }
}
