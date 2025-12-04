import 'package:dio/dio.dart';
import 'token_storage.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://localhost:7131/api", // Flutter emulator
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: "application/json",
    ),
  );

  static void setupInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.getAccessToken();
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          // Token expired → try refresh
          if (e.response?.statusCode == 401) {
            final refreshToken = await TokenStorage.getRefreshToken();
            if (refreshToken == null) {
              return handler.next(e);
            }

            try {
              final refreshResponse = await dio.post(
                "/auth/refresh",
                data: {"refreshToken": refreshToken},
              );

              final newAccessToken = refreshResponse.data["accessToken"];
              final newRefreshToken = refreshResponse.data["refreshToken"];

              await TokenStorage.saveTokens(newAccessToken, newRefreshToken);

              // Retry original request
              e.requestOptions.headers["Authorization"] = "Bearer $newAccessToken";

              final retryResponse = await dio.fetch(e.requestOptions);
              return handler.resolve(retryResponse);
            } catch (_) {
              // Refresh failed → logout user
              await TokenStorage.clearTokens();
              return handler.next(e);
            }
          }

          return handler.next(e);
        },
      ),
    );
  }

}
