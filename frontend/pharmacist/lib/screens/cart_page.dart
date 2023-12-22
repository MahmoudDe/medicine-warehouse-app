import 'package:flutter/material.dart';
import 'package:medicine_warehouse/data/dummy_data.dart';
import 'package:medicine_warehouse/widgets/cartItem.dart';
import '../models/medicine.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});
  @override
  State<CartPage> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  Medicine? removedMedicine;
  int? removedMedicineIndex;

  void increaseQuantity(int index) {
    setState(() {
      cartList[index].quantity++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (cartList[index].quantity > 1) {
        cartList[index].quantity--;
      }
    });
  }

  void deleteProduct(int index) {
    setState(() {
      removedMedicine = cartList[index];
      removedMedicineIndex = index;
      cartList.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Medicine removed from cart'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            undoDelete();
          },
        ),
      ),
    );
  }

  void undoDelete() {
    setState(() {
      if (removedMedicine != null && removedMedicineIndex != null) {
        cartList.insert(removedMedicineIndex!, removedMedicine!);
        removedMedicine = null;
        removedMedicineIndex = null;
      }
    });
  }

  @override
  Widget build(context) {
    double totalPrice = cartList.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.price) * (element.quantity));
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(fontFamily: 'Avenir'),
        ),
      ),
      body: ListView.builder(
          itemCount: cartList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(cartList[index].tradeName),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 16.0),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (direction) {
                // Delete the item from the cart
                deleteProduct(index);
              },
              child: CartItemWidget(
                medicine: cartList[index],
                increaseQuantity: () => increaseQuantity(index),
                decreaseQuantity: () => decreaseQuantity(index),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Place order logic
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Order placed successfully'),
            ),
          );
        },
        label: const Text('Place Order'),
        backgroundColor: Colors.cyan,
        icon: const Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total Price:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '\$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
