import 'package:dio/dio.dart';
import 'package:kantin_management/models/dashboard_stats.dart';
import 'package:kantin_management/models/user.dart';
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
    try {
      // 1. Wrap the potentially failing API call.
      final response = await ApiClient.dio.post(
        "/auth/login",
        data: {"email": email, "password": password},
      );

      // 2. Check for success status (200-299)
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        final accessToken = response.data["accesstoken"];
        final refreshToken = response.data["refreshToken"];

        // 3. This part is critical—if token storage fails, it will catch the error.
        await TokenStorage.saveTokens(accessToken, refreshToken); 
        
        return true; // SUCCESS path returns true
      } 
      
      // If status is NOT 2xx (e.g., 401, 404)
      return false;

    } catch (e) {
      // 4. This catches network errors, storage errors, or other unexpected errors.
      return false;
    }
  }

  Future<User> getUser() async{
    final response = await ApiClient.dio.get("/user/me");
    return User.fromJson(response.data);
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


  Future<dynamic> getDashboardSummary() async{
    try{
      final response = await ApiClient.dio.get(
        "/dashboard/summary",
      );

      print(response.data);
      return response.data;
    }catch(e){
      print(e.toString());
      return e.toString();
    }
  }

}