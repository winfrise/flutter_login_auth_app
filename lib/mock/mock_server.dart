import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class MockServer {
  static var _dioAdapter;
  static get mockClient {
    //// Exact body check
    // final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    // dioAdapter = DioAdapter(
    //  dio: dio,
    //  matcher: const FullHttpRequestMatcher(needsExactBody: true),
    // );
    print('Mock Dio----------------');
    // Basic setup
    final dio = Dio(BaseOptions());
    _dioAdapter = DioAdapter(dio: dio);
    _setupMockRoutes();
    return dio;
  }

  // 配置所有Mock路由（完全独立）
  static void _setupMockRoutes() {
    print('initMockRoutes');
    _dioAdapter.onGet(
      '/mock/user/info',
      (server) => server.reply(
        200,
        {'message': 'Success!'},
        // Reply would wait for one-sec before returning data.
        delay: const Duration(seconds: 1),
      ),
    );

    _dioAdapter.onPost(
      '/mock/user/login',
      (server) => server.reply(
        200,
        {'message': 'Success!'},
        // Reply would wait for one-sec before returning data.
        delay: const Duration(seconds: 1),
      ),
    );
  }
}
