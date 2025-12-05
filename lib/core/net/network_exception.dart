/// 自定义网络异常（区分业务错误和系统错误）
class NetworkException implements Exception {
  final int code; // 错误码（业务码/HTTP状态码/系统码）
  final String msg; // 错误信息

  NetworkException({required this.code, required this.msg});

  @override
  String toString() => 'NetworkException(code: $code, msg: $msg)';
}
