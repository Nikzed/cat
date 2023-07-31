class BaseException implements Exception {
  String? message;

  BaseException({this.message});

  @override
  String toString() => "BaseException: $message";
}