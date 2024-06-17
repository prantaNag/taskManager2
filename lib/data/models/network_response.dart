class NetworkResponse {
  final int statusCode;
  final bool inSuccess;
  final dynamic responseData;
  final String? errorMessage;

  NetworkResponse(
      {required this.statusCode,
      required this.inSuccess,
      this.responseData,
      this.errorMessage = "Something Went Wrong"});
}
