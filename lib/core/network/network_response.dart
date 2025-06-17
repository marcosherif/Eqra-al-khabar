class NetworkResponse<T> {
  T? payload;
  String? statusCode;
  bool? success;
  String? statusMessage;

  NetworkResponse({
    this.payload,
    this.statusCode,
    this.success,
    this.statusMessage,
  });

  factory NetworkResponse.fromError(String message, String statusCode) {
    return NetworkResponse(
      success: false,
      statusCode: statusCode,
      statusMessage: message,
    );
  }
}
