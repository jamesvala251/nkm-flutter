class CustomException implements Exception {
  late String errMessage;

  CustomException({
    required this.errMessage,
  });

  @override
  String toString() {
    return errMessage;
  }
}