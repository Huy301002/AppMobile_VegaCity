import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio;

  AuthService() : _dio = Dio(BaseOptions(baseUrl: Config.baseUrl));

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = '/auth/login';
    try {
      final response = await _postRequest(url, {
        'email': email,
        'password': password,
      });

      print('Response data: $response');

      // Check if the response status code is 200
      if (response['statusCode'] == 200) {
        final data = response['data'];

        // Extract the necessary data with correct keys
        final String? accessToken =
            data['accessToken']; // Changed from 'token' to 'accessToken'
        final String? refreshToken =
            data['refreshToken']; // Correct key for refreshToken
        final String? userId = data['userId']; // Correct key for userId

        // Check if accessToken and userId are not null, throw an exception if they are
        if (accessToken == null || userId == null) {
          throw Exception('Missing accessToken or userId in the response');
        }

        // Save accessToken and refreshToken to local storage (if not null)
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        if (refreshToken != null) {
          await prefs.setString('refreshToken', refreshToken);
        }
        // In ra kết quả để kiểm tra xem đã lưu thành công chưa
        print('Access Token: ${prefs.getString('accessToken')}');
        print('Refresh Token: ${prefs.getString('refreshToken')}');

        // Đảm bảo hiển thị thành công khi token đã tồn tại
        if (accessToken != null && userId != null) {
          print('Login successful');
        } else {
          print('Login failed');
        }

        // Return the relevant information
        return {
          'accessToken': accessToken,
          'refreshToken': refreshToken,
          'userId': userId,
        };
      } else {
        throw Exception(
            'Login failed: ${response['messageResponse'] ?? 'Unknown error'}');
      }
    } catch (e) {
      // Handle DioError and other exceptions without showing toast messages
      if (e is DioError) {
        throw Exception(
            'Error: ${e.response?.statusMessage ?? 'Unknown error'}');
      } else {
        throw Exception('An unexpected error occurred: ${e.toString()}');
      }
    }
  }

  Future<Map<String, dynamic>> changePassword(
    String email,
    String oldPassword,
    String newPassword,
  ) async {
    const url = '/auth/change-password';
    try {
      final response = await _postRequest(url, {
        'email': email,
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      });

      if (response['statusCode'] == 200) {
        return response['data'];
      } else {
        return {'error': response['messageResponse'] ?? 'Lỗi không xác định'};
      }
    } on DioError catch (e) {
      return {
        'error': e.response?.data['messageResponse'] ?? 'Lỗi không xác định'
      };
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    final url = '/auth/forgot-password';
    return await _postRequest(url, {
      'email': email,
    });
  }

  Future<Map<String, dynamic>> _postRequest(
      String path, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('There was a problem with the request: $e');
    }
  }

  Future<Map<String, dynamic>> getRequest(String path) async {
    try {
      final response = await _dio.get(
        path,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('There was a problem with the GET request: $e');
    }
  }

  Future<Map<String, dynamic>> getUserInfo(String userId) async {
    final url = '/user/$userId';
    print('Fetching user info from: $url');
    try {
      final userInfo = await getRequest(url);
      print('User info fetched successfully: $userInfo');
      return userInfo;
    } catch (e) {
      print('Error fetching user info: $e');
      throw e;
    }
  }
}
