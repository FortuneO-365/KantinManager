import 'package:dio/dio.dart';

class BackendWarmup {
  static Future<bool> wakeUp() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        "https://kantinmanagerapi.onrender.com/api/home",
        options: Options(
          receiveTimeout: const Duration(seconds: 120),
          sendTimeout: const Duration(seconds: 120),
        ),
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
