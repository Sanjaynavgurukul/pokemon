class ApiResponseModel {
  String message;
  bool hasError;
  Map<String, dynamic> data;

  ApiResponseModel(
      {required this.hasError, required this.data, required this.message});
}
