class ApiResponse<T, S> {
  bool success;
  String? message;
  T? data;
  S? addtionalData;
  String? errCode;
  ApiResponse(
      {required this.success,
      this.message,
      this.data,
      this.addtionalData,
      this.errCode});
}
