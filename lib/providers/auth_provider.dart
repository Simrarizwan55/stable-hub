import "dart:convert";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:http/http.dart" as http;
import "package:shared_preferences/shared_preferences.dart";
import "package:stable_hub_app/constants/constants.dart";
import "package:stable_hub_app/models/user_model.dart";

class AuthProvider extends ChangeNotifier {
  User? _user;
  String? _accessToken;

  String? get accessToken => _accessToken;

  User? get user => _user;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> fetchUser() async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      _accessToken = sharedPreferences.getString('accessToken');
      if (_accessToken != null) {
        final Uri userUri = Uri.parse("${baseUrl}api/setting/getProfile");
        http.Response response = await http.get(userUri, headers: {
          "Authorization": "Bearer $accessToken",
        });
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode == 200) {
          Map<String, dynamic> userData = responseBody['data'];
          _user = User.fromMap(userData);
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<void> _saveAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // _accessToken = sharedPreferences.getString('accessToken');
    _accessToken = token;
    await sharedPreferences.setString('accessToken', token);
  }

  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('accessToken');
    _accessToken = null;
    _user = null;
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      final Uri loginUri = Uri.parse("${baseUrl}api/user/login");
      http.Response response = await http.post(loginUri, body: {
        'email': email,
        'password': password,
      });
      print(response.statusCode);
      print(response.body);

      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        String accessToken = responseBody['data']['token'];
        _saveAccessToken(accessToken);

        Map<String, dynamic> userData = responseBody['data']['user'];
        _user = User.fromMap(userData);
        return true;
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }

  Future<String?> signUp({
    required String email,
    required String password,
    required String fullName,
    required String country,
    required String countryCode,
    required String phone,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final Uri loginUri = Uri.parse("${baseUrl}api/user/register");
      print(countryCode);
      http.Response response = await http.post(loginUri, body: {
        'email': email,
        'password': password,
        'fullName': fullName,
        'country': country,
        'countryCode': countryCode,
        'phone': phone,
      });

      Map<String, dynamic> responseBody = jsonDecode(response.body);
      print(responseBody);
      if (response.statusCode == 200) {
        String? userId = responseBody['data']?['_id'];
        Map<String, dynamic> userData = responseBody['data'];
        _user = User.fromMap(userData);
        return userId;
      } else {
        final String errorMessage =
            responseBody["desc"] ?? "Something went wrong";
        Fluttertoast.showToast(msg: errorMessage);
        // throw Exception(errorMessage);
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }

  Future<String?> otpVerify({required String userId, required String otp}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final Uri loginUri = Uri.parse("${baseUrl}api/user/verify-otp");
      http.Response response = await http.put(loginUri, body: {
        'id': userId,
        'otp': otp,
      });

      Map<String, dynamic> responseBody = jsonDecode(response.body);
      print(responseBody);
      if (response.statusCode == 200) {
        String accessToken = responseBody['token'];
        _saveAccessToken(accessToken);

        Map<String, dynamic> userData = responseBody['user'];
        _user = User.fromMap(userData);
        return _user?.email;
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }

  Future<bool> updatePassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final Uri updatePasswordUri = Uri.parse("${baseUrl}api/user/update-password");
      http.Response response = await http.put(updatePasswordUri, body: {
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      });

      Map<String, dynamic> responseBody = jsonDecode(response.body);
      print(responseBody);
      if (response.statusCode == 200) {
        // String? userId = responseBody['data'];
        // Map<String, dynamic> userData = responseBody['data'];
        // _user = User.fromMap(userData);
        return true;
      }
    }
      catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }


  Future<String?> sendOtp({
    required String email,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final Uri sendOtpUri = Uri.parse("${baseUrl}api/user/send-otp");
      http.Response response = await http.put(sendOtpUri, body: {
        'email': email,
      });

      Map<String, dynamic> responseBody = jsonDecode(response.body);
      print(responseBody);
      if (response.statusCode == 200) {
        String? userId = responseBody['data']?["id"];
        return userId;
      }
    }
    catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }

  Future<bool> updateProfile({
    required String fullName,
    required String phone,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final Uri updateProfileUri = Uri.parse("${baseUrl}api/setting/updateProfile");
      http.Response response = await http.put(updateProfileUri,headers: {
        "Authorization":"Bearer $accessToken",
      }, body: {
        'fullName': fullName,
        'phone': phone,
      });

      Map<String, dynamic> responseBody = jsonDecode(response.body);
      print(responseBody);
      if (response.statusCode == 200) {
        String? userId = responseBody['data']?['_id'];
        Map<String, dynamic> userData = responseBody['data'];
        _user = User.fromMap(userData);
        return true;
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }
}