
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Order.dart';
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
        var data = {
          'order_id': orderId,
          'medicine_id': item.medicineId,
          'quantity': item.quantity,
          'cost': item.price * item.quantity,
        };

        print('Posting the following data: $data'); // Print the data

        var response = await dio.post(
          'http://localhost:8000/api/order_items',
          data: data,
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
  Future<List<Medicine>> getMedicines() async {
    try {
      var response = await dio.get('http://localhost:8000/api/medicines');
      if (response.statusCode == 200) {
        List<dynamic> medicinesJson = response.data;
        List<Medicine> medicines = medicinesJson.map((json) {
          // Create a new Medicine object with the id and maxQuantity from the API
          var medicine = Medicine.fromJson(json);
          medicine.medicineId = json['id']; // Set the medicineId to the id from the API
          medicine.maxQuantity = json['quantity']; // This is for the quantity condition
          return medicine;
        }).toList();
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


  Future<List<dynamic>> getOrdersForUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('user_id') ?? 0;
    if (userId == 0) {
      print('user_id is not set in shared preferences');
      return [];
    }
    final String apiUrl = 'http://localhost:8000/api/orders/user/$userId';
    try {
      Response response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        List<dynamic> orders = response.data;
        for (var order in orders) {
          int orderId = order['id'] ?? 0;
          List<dynamic> orderItems = await getOrderItems(orderId);
          for (var item in orderItems) {
            int medicineId = item['medicine_id'];
            Medicine medicine = await getMedicine(medicineId);

            // Print medicine details for debugging
            print('Medicine Name: ${medicine.scientificName}');
            print('Medicine Price: ${medicine.price}');

            // Update the quantity of the medicine to the quantity from the order item
            medicine.quantity = item['quantity'];

            item['medicine'] = medicine.toJson(); // include full medicine details
            item['cost'] = double.parse(item['cost']);
          }
          order['items'] = orderItems;
        }
        return orders;
      } else {
        print('Failed to get orders with status code: ${response.statusCode}');
        return [];
      }
    } on DioException catch (e) {
      print('Dio error: $e');
      throw e;
    }
  }

  Future<Medicine> getMedicine(int medicineId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      print('Token is not set in shared preferences');
      throw Exception('Token is not set in shared preferences');
    }
    final String apiUrl = 'http://localhost:8000/api/medicines/$medicineId';
    try {
      Response response = await dio.get(
        apiUrl,
        options: Options(
          headers: {'Authorization': 'Bearer $token'}, // include the token in the request headers
        ),
      );
      if (response.statusCode == 200) {
        return Medicine.fromJson(response.data);
      } else {
        throw Exception('Failed to load medicine with id: $medicineId');
      }
    } catch (e) {
      print(e);
      throw e; // Rethrow the error to be handled by the caller
    }
  }


  Future<List<dynamic>> getOrderItems(int orderId) async {
    try {
      final String apiUrl = 'http://localhost:8000/api/order_items/order/$orderId';
      Response response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get order items with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting order items: $e');
      throw e; // Rethrow the error to be handled by the caller
    }
  }




  Future<void> deleteUserAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var options = Options(
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    try {
      var response = await dio.delete('http://localhost:8000/api/users/delete', options: options);
      if (response.statusCode == 200) {
        print('User account deleted successfully');
      } else {
        print('Failed to delete user account');
      }
    } catch (e) {
      print('Request failed with error: $e');
    }
  }





}




