import 'package:flutter/foundation.dart';
import '../models/medicine.dart';

class CartModel extends ChangeNotifier {
  final Map<String, Medicine> _items = {};

  List<Medicine> get items => _items.values.toList();

  double get totalPrice =>
      _items.values.fold(0, (total, current) => total + current.price * current.quantity);

  void add(Medicine item) {
    if (_items.containsKey(item.tradeName)) {
      _items[item.tradeName]!.quantity++;
    } else {
      _items[item.tradeName] = Medicine(
        item.medicineId,
        item.isFavorite,
        item.price,
        1, // set quantity to 1
        item.scientificName,
        item.tradeName,
        item.category,
        item.manufacturer,
        item.expiryDate,
        item.description,
        item.image,
        item.medicineName

      );
    }
    notifyListeners();
  }



  void remove(Medicine item) {
    if (_items.containsKey(item.tradeName)) {
      if (_items[item.tradeName]!.quantity > 1) {
        _items[item.tradeName]!.quantity--;
      } else {
        _items.remove(item.tradeName);
      }
    }
    notifyListeners();
  }
}

