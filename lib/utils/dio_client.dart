// lib/utils/http_client.dart （全局客户端，控制是否使用Mock）
import 'package:dio/dio.dart';
import '../mock/mock_server.dart';

const bool useMock = true;

final dioClient = useMock ? MockServer.mockClient() : Dio(BaseOptions());
