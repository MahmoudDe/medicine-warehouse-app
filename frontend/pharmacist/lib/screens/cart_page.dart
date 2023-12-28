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
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade800,
        title:  Row(
          children: [
            Icon(Iconsax.shopping_cart4, color: Colors.white,size: 30,),
            Text(
                tr('cart'),
              style: TextStyle(fontFamily: 'Tajawal', color: Colors.white,  fontSize: 27),
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
        floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Fetch user id and date automatically
          SharedPreferences prefs = await SharedPreferences.getInstance();
          int userId = prefs.getInt('user_id') ?? -1; // replace -1 with a default value or handle it appropriately
          String date = DateTime.now().toIso8601String();

          // Place order logic
          int orderId = await Server().postNewOrder(userId, 'pending', date);
          if (orderId != -1) {
            await Server().postOrderItems(Provider.of<CartModel>(context, listen: false).items, orderId);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Order placed successfully'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to place order'),
              ),
            );
          }
        },
        label:  Text(tr('placeOrder'), style: TextStyle(
            color: Colors.white
        ),),
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
