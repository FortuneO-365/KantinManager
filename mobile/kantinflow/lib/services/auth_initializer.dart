import 'package:dio/dio.dart';
import 'package:kantin_management/services/api_client.dart';
import 'package:kantin_management/services/token_storage.dart';

class AuthInitializer {
  static Future<bool> tryAutoLogin() async{
    print("hello");
    final refreshToken = await TokenStorage.getRefreshToken();
    print(refreshToken);
    if(refreshToken == null || refreshToken.isEmpty){
      return false;
    }

    try {
      final dio =  ApiClient.dio;

      final response = await dio.post(
        "/Auth/refresh",
        data: {
          "RefreshToken": refreshToken
        },
        options: Options(
          validateStatus: (status) {
            return status != null && status <= 500; 
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {

        final newAccessToken = response.data["accessToken"];
        final newRefreshToken = response.data["refreshToken"];

        await TokenStorage.saveTokens(newAccessToken, newRefreshToken);
        return true;
      }

      return false;

    } catch (e) {
      return false;
    }
  }
}