import 'package:dio/dio.dart';

// A powerful Http client for Dart, which supports Interceptors,
// Global configuration, FormData, Request Cancellation,
// File downloading, Timeout etc.

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        //we put here all fixed values
        baseUrl: 'http://192.168.1.20:',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
