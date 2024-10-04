import 'package:dio/dio.dart';
import 'package:flutter_application_1/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio;

  AuthService() : _dio = Dio(BaseOptions(baseUrl: Config.baseUrl));

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
        'error': e.response?.data['messageResponse'] ?? 'Lỗi không xác định',
      };
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    final url = '/auth/forgot-password';
    return await _postRequest(url, {
      'email': email,
    });
  }

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
        final String? accessToken = data['accessToken'];
        final String? refreshToken = data['refreshToken'];
        final String? userId = data['userId'];

        // Check if accessToken and userId are not null, throw an exception if they are
        if (accessToken == null || userId == null) {
          throw Exception('Missing accessToken or userId in the response');
        }

        // Save accessToken, refreshToken, and userId to local storage (if not null)
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        await prefs.setString(
            'userId', userId); // Lưu thêm userId vào SharedPreferences
        if (refreshToken != null) {
          await prefs.setString('refreshToken', refreshToken);
        }

        // In ra kết quả để kiểm tra xem đã lưu thành công chưa
        print('Access Token: ${prefs.getString('accessToken')}');
        print('Refresh Token: ${prefs.getString('refreshToken')}');
        print(
            'User ID: ${prefs.getString('userId')}'); // Kiểm tra xem userId đã lưu thành công chưa

        // Đảm bảo hiển thị thành công khi token đã tồn tại
        print('Login successful');

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

  Future<Map<String, dynamic>> _postRequest(
      String path, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': await _getAccessToken(), // Thêm token vào header
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
            'Authorization': await _getAccessToken(), // Thêm token vào header
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

  Future<Map<String, dynamic>> getZones() async {
    final url = '/zones';
    try {
      final response = await getRequest(url);
      print('Zones fetched successfully: $response'); // Kiểm tra kết quả trả về
      return response;
    } catch (e) {
      print('Error fetching zones: $e');
      return {'error': 'Có lỗi xảy ra khi lấy danh sách khu vực'};
    }
  }

  Future<String?> _getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<void> _refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken');
    if (refreshToken != null) {
      try {
        final response = await _postRequest('/auth/refresh-token', {
          'refreshToken': refreshToken,
        });

        if (response['statusCode'] == 200) {
          final data = response['data'];
          final String? newAccessToken = data['accessToken'];
          if (newAccessToken != null) {
            await prefs.setString('accessToken', newAccessToken);
          }
        } else {
          throw Exception('Làm mới token thất bại.');
        }
      } catch (e) {
        throw Exception('Không thể làm mới token: $e');
      }
    } else {
      throw Exception('Không có refresh token.');
    }
  }
}
