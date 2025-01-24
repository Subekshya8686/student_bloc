class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/api/v1/";
  // static const String baseUrl = "http://localhost:3000/api/v1/";

  static const String login = "auth/login";
  static const String register = "auth/register";

  static const String createBatch = "batch/createBatch";
  static const String getAllBatch = "batch/getAllBatches";
  static const String deleteBatch = "batch";

  static const String createCourse = "course/createCourse";
  static const String deleteCourse = "course/";
  static const String getAllCourse = "course/getAllCourse";
}
