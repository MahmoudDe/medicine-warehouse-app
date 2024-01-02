import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medicine_warehouse/data/dummy_data.dart';
import 'package:medicine_warehouse/widgets/cartItem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Provider/cart_model.dart';
import '../models/medicine.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../server/server.dart';


class CartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade700,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart, color: Colors.white,size: 30),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                  tr('cart'),
                style: TextStyle(fontFamily: 'Tajawal', color: Colors.white,  fontSize: 27),
              ),
            ),
          ],
        ),
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) => ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(cart.items[index].medicineId.toString()), // Use medicineId as the key
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
                cart.remove(cart.items[index]);
              },
              child: CartItemWidget(
                medicine: cart.items[index],
              ),
            );
          },
        ),
      ),
        floatingActionButton:FloatingActionButton.extended(
          onPressed: () async {
            // Fetch user id and date automatically
            SharedPreferences prefs = await SharedPreferences.getInstance();
            int userId = prefs.getInt('user_id') ?? -1; // replace -1 with a default value or handle it appropriately
            String date = DateTime.now().toIso8601String();

            // Place order logic
            try {
              int orderId = await Server().postNewOrder(userId, 'pending', date);
              if (orderId != -1) {
                try {
                  await Server().postOrderItems(Provider.of<CartModel>(context, listen: false).items, orderId);
                  if (Provider.of<CartModel>(context, listen: false).items.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cart is empty'),
                      ),
                    );
                  } else {
                    // Clear cart after successful order placement
                    Provider.of<CartModel>(context, listen: false).clearCart();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Order placed successfully'),
                      ),
                    );
                  }
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Failed to post order item: $e'),
                        actions: [
                          TextButton(
                            child: Text('OK'),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to place order'),
                  ),
                );
              }
            } on HttpException catch (e) {
              if (e.message == 400) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text('Sorry'),
                      content: Text('Medicine is no longer available is the warehouse'),
                      actions: [
                        TextButton(
                          child: Text('OK', style: TextStyle(color: Colors.orangeAccent),),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            }
          },
          label:  Text(tr('placeOrder'), style: TextStyle(
            color: Colors.white
        ),
          ),
        backgroundColor: Colors.cyan.shade800,
        icon: const Icon(Icons.shopping_cart, color: Colors.white,),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Consumer<CartModel>(
        builder: (context, cart, child) => Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey[200],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(tr('totalPrice'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${cart.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
