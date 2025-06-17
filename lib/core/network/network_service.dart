import 'package:dio/dio.dart';
import 'package:eqra_el_khabar/config/constants/base_url.dart';
import 'package:eqra_el_khabar/config/constants/news_api_key.dart';
import 'package:eqra_el_khabar/core/network/logger_interceptor.dart';
import 'package:eqra_el_khabar/core/network/network_response.dart';

enum MethodType { get, post, put, delete, patch }

class NetworkService {
  static late Dio _dio;

  NetworkService() {
    _dio = Dio()..options.baseUrl = newsApiBaseUrl;

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters['apiKey'] = newsApiKey;
          return handler.next(options);
        },
      ),
    );

    _dio.interceptors.add(LoggerInterceptor());
  }

  Future<NetworkResponse<T>> request<T>({
    required String path,
    required MethodType method,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic> json)? payloadParser,
  }) async {
    NetworkResponse<T> networkResponse;
    Response response;
    try {
      switch (method) {
        case MethodType.get:
          response = await _dio.get(
            path,
            // data: payload,
            queryParameters: queryParameters,
          );
          break;
        case MethodType.post:
          response = await _dio.post(
            path,
            data: data,
            queryParameters: queryParameters,
          );
          break;
        case MethodType.put:
          response = await _dio.put(
            path,
            data: data,
            queryParameters: queryParameters,
          );
          break;
        case MethodType.delete:
          response = await _dio.delete(
            path,
            data: data,
            queryParameters: queryParameters,
          );
          break;
        case MethodType.patch:
          response = await _dio.patch(
            path,
            data: data,
            queryParameters: queryParameters,
          );
          break;
      }

      networkResponse = NetworkResponse(
        payload: payloadParser?.call(response.data),
        statusCode: response.statusCode.toString(),
        success: true,
      );
    } on DioException catch (e) {
      networkResponse = NetworkResponse<T>.fromError(
        (e.response?.data['status_message'] ?? e.message).toString(),
        (e.response?.data?['status_code'] ?? e.response?.statusCode).toString(),
      );
    }
    return networkResponse;
  }
}
