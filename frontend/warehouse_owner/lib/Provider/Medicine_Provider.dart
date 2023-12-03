

import 'package:flutter/material.dart';

import '../Server/server.dart';
import '../classes/Medicine.dart';
import 'package:provider/provider.dart';


class MedicineProvider extends ChangeNotifier {
  Server _server = Server();
  List<Medicine> _medicines = [];
  List<Medicine> _filteredMedicines = [];

  List<Medicine> get medicines => _filteredMedicines;

  Future<void> setMedicines() async {
    _medicines = await _server.getMedicines();
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
  Future<void> addMedicine(Medicine medicine) async {
    await _server.addMedicine(medicine as Map<String, dynamic>);
    _medicines.add(medicine);
    _filteredMedicines = _medicines;
    notifyListeners();
  }


}
