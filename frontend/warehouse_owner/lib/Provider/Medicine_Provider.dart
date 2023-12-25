import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Server/server.dart';
import '../classes/Medicine.dart';
import 'package:provider/provider.dart';


class MedicineProvider extends ChangeNotifier {
  Server _server = Server();
  List<Medicine> _medicines = [];
  List<Medicine> _filteredMedicines = [];

  List<Medicine> get medicines => _filteredMedicines;

  Future<void> setMedicines() async {
    // _medicines = await _server.getMedicines();
    _filteredMedicines = _medicines;
    notifyListeners();
  }



  void filterByCategory(String category) {
    if (category == 'All') {
      _filteredMedicines = _medicines;
    } else {
      _filteredMedicines = _medicines.where((medicine) => medicine.category == category).toList();
    }
    notifyListeners();
  }



void resetFilter() {
    _filteredMedicines = _medicines;
    notifyListeners();
  }
  List<String> get categories {
    return _medicines.map((medicine) => medicine.category).toSet().toList();
  }

  void decreaseQuantity(String name, int amount) {
    for (var medicine in _medicines) {
      if (medicine.commercialName == name) {
        if (medicine.quantity >= amount) {
          medicine.quantity -= amount;
        } else {
          print('Not enough stock for this medicine');
        }
        break;
      }
    }
    notifyListeners();
  }

  // void addMedicine(Medicine medicine) {
  //   _medicines.add(medicine);
  //   notifyListeners();
  // }
  Dio _dio = new Dio();
  Future<void> addMedicine(Medicine medicine) async {
    await _server.addMedicine(medicine as Map<String, dynamic>);
    _medicines.add(medicine);
    _filteredMedicines = _medicines;
    notifyListeners();
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
        'http://localhost:8000/api/medicines',
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
      print('Request failed with error: $e');
      return [];
    }
  }

  // fetch categories

  Future<List<String>> getCategories() async {
    try {
      var response = await _dio.get('http://localhost:8000/api/categories');
      if (response.statusCode == 200) {
        return List<String>.from(response.data.map((item) => item['name'].toString()));
      } else {
        print('Failed to fetch categories');
        return [];
      }
    } catch (e) {
      print('Request failed with error: $e');
      return [];
    }
  }
// fetch medicines in certain category
  Future<List<Medicine>> getMedicinesByCategory(String category) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      Dio _dio = Dio(
        BaseOptions(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      var response = await _dio.get('http://localhost:8000/api/medicines/search/$category');
      print('Response data: ${response.data}'); // Add this line
      if (response.statusCode == 200) {
        return List<Medicine>.from(response.data.map((item) => Medicine.fromJson(item)));
      } else {
        print('Failed to fetch medicines');
        return [];
      }
    } catch (e) {
      print('Request failed with error: $e');
      return [];
    }
  }


}
