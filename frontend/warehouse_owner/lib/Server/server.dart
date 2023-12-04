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
      'http://localhost:8000/api/login', // replace with your API URL
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
        'http://localhost:8000/api/admin/medicines', // replace with your API URL
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
        'http://localhost:8000/api/admin/categories', // replace with your API URL
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

}
