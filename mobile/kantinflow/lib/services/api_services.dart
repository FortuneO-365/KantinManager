import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kantin_management/models/user.dart';
import 'package:kantin_management/services/api_client.dart';
import 'package:kantin_management/services/token_storage.dart';

class ApiServices {

  /// **************************
  /// Auth API Calls
  ///***************************
 
  
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

  Future<dynamic> initiateForgotPassword({
    required String email,
  }) async{
    try {
      final response = await ApiClient.dio.post(
        "/Auth/initiate-forgot-password",
        data: {
          "email": email,
        },
        options: Options(
          validateStatus: (status) {
            return status != null && status <= 500; 
          },
        ),
      );

      return response.data;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> completeForgotPassword({
    required String code,
    required String password,
  }) async{
    try {
      final response = await ApiClient.dio.post(
        "/Auth/complete-forgot-password",
        data: {
          "code": code,
          "password": password
        },
        options: Options(
          validateStatus: (status) {
            return status != null && status <= 500; 
          },
        ),
      );

      return response.data;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> logout() async {
    try {

      final response = await ApiClient.dio.post(
        "/auth/logout",
        options: Options(
          validateStatus: (status) {
            return status != null && status <= 500; 
          },
        ),
      );
      if(response.statusCode! >= 200 && response.statusCode! <= 299){
        await TokenStorage.clearTokens();
        return response.data;
      }
      
    } catch (e) {
      return e.toString(); 
      
    }
  }

  /// **************************
  /// User API Calls
  ///***************************

  Future<User> getUser() async{
    final response = await ApiClient.dio.get("/user/me");
    return User.fromJson(response.data);
  }

  Future<dynamic> updateUser({
    String? firstName, 
    String? lastName, 
    String? address,
    String? gender
  }) async{
    try {
      final response = await ApiClient.dio.patch(
        "/User/me",
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "gender": gender,
          "address": address
        },
        options: Options(
          validateStatus: (status) {
            return status != null && status <= 500; 
          },
        ),
      );  

      return response.data;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> uploadProfileImage({
    required XFile imageFile
  }) async {

    try{

      final file = await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.name,
      );

        final formData = FormData.fromMap({
          "file": file,
        });

      final response = await ApiClient.dio.post(
        "/user/upload-profile-image", 
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          validateStatus: (status) {
            return status != null && status <= 500; 
          },
        )
      );
      return response.data;
    }catch(e){
      return e.toString();
    }

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

  Future<Response> deleteAccount() {
    return ApiClient.dio.delete("/user/me");
  }

  /// **************************
  /// Dashboard API Calls
  ///***************************


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

  /// **************************
  /// Product API Calls
  ///***************************

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

  Future<dynamic> removeProduct({
    required int productId
  }) async{
    try {
      final response = await ApiClient.dio.delete(
        "/Product/$productId"
      );

      return response.data;
      
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> getProduct({
    required int productId
  }) async{
    try {
      final response = await ApiClient.dio.get(
        "/Product/$productId"
      );

      return response.data;
      
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> editProduct({
    required int productId,
    required String productName,
    required double sellingPrice,
    required int quantity,
  }) async{
    try {
      final response = await ApiClient.dio.patch(
        "/Product/$productId",
        data: {
          "productName": productName,
          "sellingPrice": sellingPrice,
          "quantity": quantity,
          "currency": 1
        }
      );

      return response.data;
      
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> uploadProductImage({
    required int productId,
    required XFile imageFile
  }) async{
    try {
      final file = await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.name,
      );

      final formData = FormData.fromMap({
        "file": file,
      });

      final response = await ApiClient.dio.post(
        "/Product/upload-image/$productId",
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          validateStatus: (status) {
            return status != null && status <= 500; 
          },
        ),
      );
      return response.data;
      
    } catch (e) {
      return e.toString();
    }
  }

  /// **************************
  /// Sales API Calls
  ///***************************

  Future<dynamic> recordSale({
    required int productId,
    required int quantitySold,
  }) async{
    try{
      final response = await ApiClient.dio.post(
        "/Sales",
        data: {
          "productId": productId,
          "quantity": quantitySold,
        },
      );
      return response.data;
    }catch(e){
      return e.toString();
    }
  }

  Future<dynamic> getSalesData() async{
    try{
      final response = await ApiClient.dio.get(
        "/Sales",
      );
      return response.data;
    }catch(e){
      return e.toString();
    }
  }
}