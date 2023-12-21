
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Server {
  Dio dio = Dio();

  Future<void> registerUser(String email, String password) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    final String apiUrl = 'http://localhost:8000/api/users/register';
    try {
      Response response = await dio.post(
        apiUrl,
        data: {
          'email': email,
          'password': password,
          'password_confirmation': password, // Assuming password confirmation is the same
        },
      );
      if (response.statusCode == 201) {
        // Handle successful registration
        print('Registration successful');
        print(response.data);
      } else {
        // Handle other status codes
        print('Registration failed with status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      // Handle Dio errors
      print('Dio error: $e');
    }
  }


  Future<void> loginUser(String email, String password) async {
    final String apiUrl = 'http://localhost:8000/api/users/login';
    try {
      Response response = await dio.post(
        apiUrl,
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        // Handle successful login
        print('Login successful');
        return response.data; // Return the response data
      } else {
        // Handle other status codes
        print('Login failed with status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      // Handle Dio errors
      print('Dio error: $e');
      throw e; // Rethrow the error to be handled by the caller
    }
  }



}
