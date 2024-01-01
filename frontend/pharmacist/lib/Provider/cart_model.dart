import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/medicine.dart';

class CartModel extends ChangeNotifier {
  final Map<String, Medicine> _items = {};

  List<Medicine> get items => _items.values.toList();

  double get totalPrice =>
      _items.values.fold(
          0, (total, current) => total + current.price * current.quantity);

  bool add(Medicine item, BuildContext context) {
    String idKey = item.medicineId.toString() + item.scientificName;
    if (_items.containsKey(idKey)) {
      if (_items[idKey]!.quantity < item.maxQuantity) {
        _items[idKey]!.quantity++;
        notifyListeners();
        return true;
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Alert'),
              content: const Text('The ordered quantity is more than the available quantity.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return false;
      }
    } else {
      final newItem = Medicine(
        item.medicineId,
        item.isFavorite,
        item.price,
        1,
        item.scientificName,
        item.tradeName,
        item.category,
        item.manufacturer,
        item.expiryDate,
        item.description,
        item.image,
        item.medicineName,
        item.maxQuantity,
      );
      _items[idKey] = newItem;
      notifyListeners();
      return true;
    }
  }


  void remove(Medicine item) {
    String idKey = item.medicineId.toString() + item.scientificName;
    if (_items.containsKey(idKey)) {
      if (_items[idKey]!.quantity > 1) {
        _items[idKey]!.quantity--;
      } else {
        _items.remove(idKey);
      }
    }
    notifyListeners();
  }
}
