import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/Medicine.dart';

class Server {
  Dio _dio = Dio();

  Future<void> loginAdmin(String email, String password) async {
    var options = Options(
      headers: {
        'Accept': 'application/json',
      },
    );

    var response = await _dio.post(
      'http://localhost:8000/api/login',
      data: {
        'email': email,
        'password': password,
      },
      options: options,
    );

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response.data['token']);
    } else {
      print('Failed to log in admin');
    }
  }

  Future<void> addMedicine(Map<String, dynamic> medicine) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var options = Options(
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    try {
      var response = await _dio.post(
        'http://localhost:8000/api/admin/medicines',
        data: medicine,
        options: options,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Medicine created successfully');
      } else {
        print('Failed to create medicine');
      }
    } catch (e) {
      print('Request failed with error: $e');
    }
  }
  // Future<List<Medicine>> getMedicines() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('token');
  //
  //   var options = Options(
  //     // headers: {
  //     //   'Authorization': 'Bearer $token',
  //     //   'Accept': 'application/json',
  //     // },
  //   );
  //
  //   try {
  //     var response = await _dio.get(
  //       'http://localhost:8000/api/medicines', // replace with your API URL
  //       options: options,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       List<dynamic> body = response.data;
  //       return body.map((dynamic item) => Medicine.fromJson(item)).toList();
  //     } else {
  //       print('Failed to fetch medicines');
  //       return [];
  //     }
  //   } catch (e) {
  //     print('Request failed with error: $e');
  //     return [];
  //   }
  // }
  Future<void> addCategory(Map<String, dynamic> category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var options = Options(
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    try {
      var response = await _dio.post(
        'http://localhost:8000/api/admin/categories',
        data: category,
        options: options,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Category created successfully');
      } else {
        print('Failed to create category');
      }
    } catch (e) {
      print('Request failed with error: $e');
    }
  }



  Future<List<dynamic>> getOrders() async {
    final String apiUrl = 'http://localhost:8000/api/orders';
    try {
      Response response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        print('Failed to get orders with status code: ${response.statusCode}');
        return [];
      }
    } on DioException catch (e) {
      print('Dio error: $e');
      throw e;
    }
  }
  Future<List<dynamic>> getOrderItems(int orderId) async {
    final String apiUrl = 'http://localhost:8000/api/order_items/order/$orderId';
    try {
      Response response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        print('Failed to get order items with status code: ${response.statusCode}');
        return [];
      }
    } on DioException catch (e) {
      print('Dio errorrs: $e');
      throw e; // Rethrow the error to be handled by the caller
    }
  }
  Future<List<Medicine>> getMedicines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var options = Options(
      // headers: {
      //   'Authorization': 'Bearer $token',
      //   'Accept': 'application/json',
      // },
    );

    try {
      var response = await _dio.get(
        'http://localhost:8000/api/medicines', // replace with your API URL
        options: options,
      );

      if (response.statusCode == 200) {
        List<dynamic> body = response.data;
        return body.map((dynamic item) => Medicine.fromJson(item)).toList();
      } else {
        print('Failed to fetch medicines');
        return [];
      }
    } catch (e) {
      print('Request failed with errorrrrr: $e');
      return [];
    }
  }


  Future<void> acceptOrder(int orderId) async {
    final String apiUrl = 'http://localhost:8000/api/orders/$orderId/accept';
    try {
      Response response = await _dio.post(apiUrl);
      if (response.statusCode == 200) {
        print('Order accepted successfully');
      } else {
        print('Failed to accept order with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Dio error: $e');
      throw e;
    }
  }
  Future<void> rejectOrder(int orderId) async {
    final String apiUrl = 'http://localhost:8000/api/orders/$orderId/reject';
    try {
      Response response = await _dio.post(apiUrl);
      if (response.statusCode == 200) {
        print('Order rejected successfully');
      } else {
        print('Failed to reject order with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Dio error: $e');
      throw e;
    }
  }
  Future<void> recieveOrder(int orderId) async {
    final String apiUrl = 'http://localhost:8000/api/admin/orders/changeStatus/$orderId';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      Response response = await _dio.put(
        apiUrl,
        data: {
          "status": "received",
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token", // Add the authorization token here
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Order received successfully');
      } else {
        print('Failed to receive order with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Dio error: $e');
      throw e;
    }
  }




  Future<void> logoutUser() async {
    final String apiUrl = 'http://localhost:8000/api/users/logout';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }

    try {
      Response response = await _dio.post(apiUrl);
      if (response.statusCode == 200) {
        // Handle successful logout
        print('Logout successful');

        await prefs.setBool('isLoggedIn', false);
        await prefs.remove('token');
      } else {
        print('Logout failed with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Dio error: $e');
      throw e;
    }
  }

}
