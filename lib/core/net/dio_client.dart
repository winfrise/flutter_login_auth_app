import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'network_config.dart';
import 'network_exception.dart'; // 后续创建自定义异常

/// Dio 单例客户端
class DioClient {
  static DioClient? _instance;
  late Dio _dio;

  /// 私有构造方法
  DioClient._internal() {
    // 初始化 Dio
    _dio = Dio(
      BaseOptions(
        baseUrl: NetworkConfig.baseUrl,
        connectTimeout: Duration(milliseconds: NetworkConfig.connectTimeout),
        receiveTimeout: Duration(milliseconds: NetworkConfig.receiveTimeout),
        headers: NetworkConfig.defaultHeaders,
        responseType: ResponseType.json,
      ),
    );

    // 添加拦截器
    _addInterceptors();
  }

  /// 获取单例
  static DioClient get instance {
    _instance ??= DioClient._internal();
    return _instance!;
  }

  /// 获取原始 Dio 实例（特殊场景使用）
  Dio get dio => _dio;

  /// 添加拦截器
  void _addInterceptors() {
    // 1. Cookie 拦截器（可选，根据业务需求）
    _dio.interceptors.add(CookieManager(CookieJar()));

    // 2. 日志拦截器（开发环境开启，生产环境关闭）
    _dio.interceptors.add(
      LogInterceptor(
        request: true, // 打印请求信息
        requestHeader: true, // 打印请求头
        requestBody: true, // 打印请求体
        responseHeader: true, // 打印响应头
        responseBody: true, // 打印响应体
        error: true, // 打印错误信息
      ),
    );

    // 3. 自定义拦截器（处理 token、请求头、响应统一解析等）
    _dio.interceptors.add(
      InterceptorsWrapper(
        // 请求拦截
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
          // 示例：添加 token 到请求头
          String? token = _getToken(); // 从本地缓存获取 token
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options); // 继续请求
        },

        // 响应拦截
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          // 统一解析响应数据（假设接口返回格式：{code: 200, msg: "成功", data: {...}}）
          Map<String, dynamic> data = response.data;
          int code = data['code'] ?? -1;
          String msg = data['msg'] ?? '请求失败';

          if (code == 200) {
            // 业务成功，只返回 data 给上层
            response.data = data['data'];
            handler.next(response);
          } else {
            // 业务错误，抛出自定义异常
            handler.reject(
              DioException(
                requestOptions: response.requestOptions,
                error: NetworkException(code: code, msg: msg),
              ),
            );
          }
        },

        // 错误拦截
        onError: (DioException e, ErrorInterceptorHandler handler) {
          // 统一处理错误（网络错误、超时、业务错误等）
          NetworkException exception = _convertDioErrorToNetworkException(e);
          handler.reject(
            DioException(
              requestOptions: e.requestOptions,
              error: exception,
              type: e.type,
              message: exception.msg,
            ),
          );
        },
      ),
    );
  }

  /// 从本地缓存获取 token（示例方法，需根据实际实现）
  String? _getToken() {
    // 示例：从 SharedPreferences 获取
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // return prefs.getString('token');
    return null;
  }

  /// 将 Dio 错误转换为自定义网络异常
  NetworkException _convertDioErrorToNetworkException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return NetworkException(code: -1, msg: '请求超时，请检查网络');
    } else if (e.type == DioExceptionType.connectionError) {
      return NetworkException(code: -2, msg: '网络连接失败，请检查网络');
    } else if (e.type == DioExceptionType.badResponse) {
      // HTTP 状态码错误（404、500 等）
      int statusCode = e.response?.statusCode ?? -3;
      return NetworkException(code: statusCode, msg: '服务器错误（$statusCode）');
    } else if (e.error is NetworkException) {
      // 业务错误（已在响应拦截器抛出）
      return e.error as NetworkException;
    } else {
      return NetworkException(code: -999, msg: '未知错误：${e.message}');
    }
  }

  // ---------------------- 通用请求方法封装 ----------------------
  /// GET 请求
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      Response response = await _dio.get(
        path,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw e.error as NetworkException;
    }
  }

  /// POST 请求
  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      Response response = await _dio.post(
        path,
        data: data,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw e.error as NetworkException;
    }
  }

  /// PUT 请求
  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      Response response = await _dio.put(
        path,
        data: data,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw e.error as NetworkException;
    }
  }

  /// DELETE 请求
  Future<T> delete<T>(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      Response response = await _dio.delete(
        path,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw e.error as NetworkException;
    }
  }

  /// 上传文件
  Future<T> upload<T>(
    String path, {
    required MultipartFile file,
    String fileName = 'file',
    Map<String, dynamic>? params,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        fileName: file,
        if (params != null) ...params,
      });
      Response response = await _dio.post(
        path,
        data: formData,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
      return response.data as T;
    } on DioException catch (e) {
      throw e.error as NetworkException;
    }
  }
}