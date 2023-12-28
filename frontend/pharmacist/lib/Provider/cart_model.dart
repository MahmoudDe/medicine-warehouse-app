import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/medicine.dart';

class CartModel extends ChangeNotifier {
  final Map<String, Medicine> _items = {};

  List<Medicine> get items => _items.values.toList();

  double get totalPrice =>
      _items.values.fold(
          0, (total, current) => total + current.price * current.quantity);

  void add(Medicine item, BuildContext context) {
    String idKey = item.medicineId.toString() + item.scientificName;
    if (_items.containsKey(idKey)) {
      // Item already exists in the cart
      if (_items[idKey]!.quantity < item.maxQuantity) {
        // The quantity in the cart is less than the quantity in the warehouse
        _items[idKey]!.quantity++;
        print('Quantity in the cart: ${_items[idKey]!.quantity}');
        print('Quantity in the warehouse: ${item.maxQuantity}');
      } else {
        // The quantity in the cart is more than or equal to the quantity in the warehouse
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
      }
    } else {
      // Item doesn't exist in the cart, add it with quantity 1
      final newItem = Medicine(
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
        item.medicineName,
        item.maxQuantity,
      );
      _items[idKey] = newItem;
      print('New item added to the cart with quantity 1');
    }
    notifyListeners();
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
