import 'package:dio/dio.dart';

Future<void> fetchDataWithDio() async {
  final dio = Dio();
  try {
    final response = await dio.get('https://api.example.com/users/1');
  }
  // Dio专属异常类型，包含详细的错误分类
  on DioException catch (e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        print('连接超时');
        break;
      case DioExceptionType.sendTimeout:
        print('发送超时');
        break;
      case DioExceptionType.receiveTimeout:
        print('接收超时');
        break;
      case DioExceptionType.badResponse:
        print('响应错误：${e.response?.statusCode}');
        break;
      case DioExceptionType.cancel:
        print('请求被取消');
        break;
      case DioExceptionType.connectionError:
        print('网络连接错误');
        break;
      default:
        print('未知错误：${e.message}');
    }
  }
}
