import 'package:dio/dio.dart';
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

  Future<dynamic> verifyUser({
    required String email,
    required String verificationCode,
  }) async {
    try {
      final response = await ApiClient.dio.post(
        "/auth/verify-email",
        data: {
          "email": email,
          "code": verificationCode,
        },
        options: Options(
          validateStatus: (status) {
            return status != null && status <= 500; 
          },
        ),
      );
      return response.data;
    } catch (e) {
      e.toString();
    }
  }

  Future<dynamic> resendCode({
    required String email,
  })async{
    final response = await ApiClient.dio.post(
      "/auth/resend-verification",
      data: {
        "email": email
      },
    );
    return response.data;
  }

  Future<dynamic> login(String email, String password) async {
    try {
      // 1. Wrap the potentially failing API call.
      final response = await ApiClient.dio.post(
        "/auth/login",
        data: {"email": email, "password": password},
        options: Options(
          validateStatus: (status) {
            return status != null && status <= 500; 
          },
        ),
      );

      // 2. Check for success status (200-299)
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        final accessToken = response.data["accesstoken"];
        final refreshToken = response.data["refreshToken"];

        // 3. This part is critical—if token storage fails, it will catch the error.
        await TokenStorage.saveTokens(accessToken, refreshToken); 
        
        return "Success"; // SUCCESS path returns true
      }
      return response.data;

    } catch (e) {
      // 4. This catches network errors, storage errors, or other unexpected errors.
      return e.toString();
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
      return response.data;
    }catch(e){
      return e.toString();
    }
  }

  Future<dynamic> getAllProducts() async{
    try{
      final response = await ApiClient.dio.get(
        "/Product",
      );
      return response.data;
    }catch(e){
      return e.toString();
    }
  }

  Future<dynamic> addNewProduct({
  required String productName,
  required double sellingPrice,
  required int quantity,
}) async{
    try{
      final response = await ApiClient.dio.post(
        "/Product",
        data: {
          "productName": productName,
          "sellingPrice": sellingPrice,
          "quantity": quantity,
          "currency": 1  
        },
      );
      return response.data;
    }catch(e){
      return e.toString();
    }
  }
}