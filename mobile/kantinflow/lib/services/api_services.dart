import 'package:dio/dio.dart';
import 'package:kantin_management/services/api_client.dart';
import 'package:kantin_management/services/token_storage.dart';

class ApiServices {

  // Future methods for API calls will be added here in the future.
  Future<Response> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) {
    return ApiClient.dio.post(
      "/auth/register",
      data: {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password
      },
    );
  }

  Future<Response> verifyUser({
    required String email,
    required String verificationCode,
  }) {
    return ApiClient.dio.post(
      "/auth/verify-email",
      data: {
        "email": email,
        "code": verificationCode,
      },
    );
  }

  Future<bool> login(String email, String password) async {
    final response = await ApiClient.dio.post(
      "/auth/login",
      data: {"email": email, "password": password},
    );

    final accessToken = response.data["accessToken"];
    final refreshToken = response.data["refreshToken"];

    await TokenStorage.saveTokens(accessToken, refreshToken);
    return true;
  }

  Future<Response> getUser() {
    return ApiClient.dio.get("/user/me");
  }

  Future<Response> updateUser({String? firstName, String? lastName, String? email}) {
    return ApiClient.dio.patch(
      "/user/me",
      data: {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
      },
    );
  }

  Future<String> uploadProfileImage(String filePath) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath),
    });

    final res = await ApiClient.dio.post("/user/upload-profile-image", data: formData);
    return res.data["imageUrl"];
  }

  Future<Response> changePassword(String oldPassword, String newPassword) {
    return ApiClient.dio.post(
      "/user/change-password",
      data: {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      },
    );
  }

  Future<void> logout() async {
    await ApiClient.dio.post("/auth/logout");
    await TokenStorage.clearTokens();
  }

  Future<Response> deleteAccount() {
    return ApiClient.dio.delete("/user/me");
  }

}