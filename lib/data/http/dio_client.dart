import 'package:dio/dio.dart';

class DioClient {
  DioClient() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 15),
        // Base URL is unused because we call full endpoint in the datasource.
      ),
    );

    // Add default headers if needed.
    _dio.options.headers.addAll({
      'Accept': 'application/json',
    });
  }

  late final Dio _dio;

  Dio get dio => _dio;
}

