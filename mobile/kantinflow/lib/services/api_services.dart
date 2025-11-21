import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  // Add your API service methods here

  static const String baseUrl = "https://localhost:7131/api";
  // For Android Emulator
  // static const String baseUrl = "https://10.0.2.2:7131/api";

  //REGISTER USER
  static Future<String?> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/Auth/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "FirstName": firstName,
        "LastName": lastName,
        "Email": email,
        "Password": password,
      }),
    );

    if (response.statusCode == 200) {
      return response.body; // success message
    } else {
      return "Error: ${response.body}";
    }
  }

  //VERIFY CODE
  static Future<String?> verifyCode({
    required String email,
    required String code,
  }) async {
    final url = Uri.parse('$baseUrl/Auth/verify-email');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "code": code,
      }),
    );

    if (response.statusCode == 200) {
      return response.body; // success message
    } else {
      return "Error: ${response.body}";
    }
  }

  //Login
  static Future<String?> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/Auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "Email": email,
        "Password": password,
      }),
    );

    if (response.statusCode == 200) {
      return response.body; // token or success message
    } else {
      return "Error: ${response.body}";
    }
  }
}