import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  final _logger = Logger(
    printer: PrettyPrinter(
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.i({
      'method': options.method,
      'path': options.path,
      'header': options.headers,
      'queryParameters': options.queryParameters,
      'decrypted body': options.extra['requestBeforeEncryption'],
      'encrypted body': options.data,
    });

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d({
      'method': response.requestOptions.method,
      'path': response.realUri.toString(),
      'headers': response.headers,
      'queryParameters': response.requestOptions.queryParameters,
      'status code': response.statusCode,
      'status message': response.statusMessage,
      'encrypted response': response.extra['responseBeforeDecryption'],
      'decrypted response': response.data,
    });
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    _logger.e(
      {
        'method': err.requestOptions.method,
        'path': err.requestOptions.path,
        'headers': err.requestOptions.headers,
        'queryParameters': err.requestOptions.queryParameters,
        'status code': err.response?.statusCode,
        'status message': err.response?.statusMessage,
        'encrypted response': err.response?.extra['responseBeforeDecryption'],
        'decrypted response': err.response?.data,
      },
      error: err.message,
      stackTrace: err.stackTrace,
    );
    super.onError(err, handler);
  }
}
