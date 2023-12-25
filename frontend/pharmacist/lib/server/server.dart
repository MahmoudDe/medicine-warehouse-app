
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/medicine.dart';


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
          'password_confirmation': password,
        },
      );
      if (response.statusCode == 201) {
        // Handle successful registration
        print('Registration successful');
        print(response.data);
      } else {
        print('Registration failed with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
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

        // Save the token and user id in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data['token']);
        await prefs.setInt('user_id', response.data['user']['id']);

        return response.data;
      } else {
        // Handle other status codes
        print('Login failed with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Dio error: $e');
      throw e; // Rethrow the error to be handled by the caller
    }
  }


  Future<void> logoutUser() async {
    final String apiUrl = 'http://localhost:8000/api/users/logout';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    try {
      Response response = await dio.post(apiUrl);
      if (response.statusCode == 200) {
        // Handle successful logout
        print('Logout successful');

        await prefs.setBool('isLoggedIn', false);
        await prefs.remove('token');
      } else {
        // Handle other status codes
        print('Logout failed with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Dio error: $e');
      throw e;
    }
  }

  Future<List<Medicine>> getMedicines() async {
    try {
      var response = await dio.get('http://localhost:8000/api/medicines');
      if (response.statusCode == 200) {
        List<dynamic> medicinesJson = response.data;
        List<Medicine> medicines = medicinesJson.map((json) => Medicine.fromJson(json)).toList();
        return medicines;
      } else {
        throw Exception('Failed to load medicines');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Medicine>> getMedicinesByCategory(String category) async {
    // Retrieve the user token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    try {
      var response = await dio.get('http://localhost:8000/api/medicines/search/$category');
      if (response.statusCode == 200) {
        List<dynamic> medicinesJson = response.data;
        List<Medicine> medicines = medicinesJson.map((json) => Medicine.fromJson(json)).toList();
        return medicines;
      } else {
        throw Exception('Failed to load medicines');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
  Future postNewOrder(int userId, String status, String date) async {
    try {
      var response = await dio.post(
        'http://localhost:8000/api/orders',
        data: {
          'user_id': userId,
          'status': status,
          'date': date,
          'total_amount': 0,
        },
      );

      if (response.statusCode == 201) {
        print('Order posted successfully');
        return response.data['id'];
      } else {
        print('Failed to post order');
        return -1;
      }
    } catch (e) {
      print('Error: $e');
      return -1;
    }
  }

  Future<void> postOrderItems(List<Medicine> items, int orderId) async {
    try {
      for (var item in items) {
        var response = await dio.post(
          'http://localhost:8000/api/order_items',
          data: {
            'order_id': orderId,
            'medicine_id': item.medicineId,
            'quantity': item.quantity,
            'cost': item.price * item.quantity,
          },
        );

        if (response.statusCode == 201) {
          print('Order item posted successfully');
        } else {
          print('Failed to post order item');
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }


}




