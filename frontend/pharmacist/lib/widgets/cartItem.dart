import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/cart_model.dart';
import '../models/medicine.dart';
import 'package:iconsax/iconsax.dart';

class CartItemWidget extends StatelessWidget {
  final Medicine medicine;

  const CartItemWidget({
    super.key,
    required this.medicine,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
            )
          ]),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            child: Image.asset(
              medicine.image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    medicine.scientificName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${medicine.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Provider.of<CartModel>(context, listen: false).remove(medicine);
                        medicine.quantity--;
                        if (medicine.quantity > 1) {
                          Provider.of<CartModel>(context, listen: false).add(medicine);
                        }
                      },
                      icon: const Icon(Iconsax.minus_cirlce5, color: Colors.orangeAccent,size: 30,),
                    ),
                    Text(
                      medicine.quantity.toString(),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<CartModel>(context, listen: false).add(medicine);
                      },
                      icon: const Icon(Iconsax.add_circle5, color: Colors.cyan,size: 30),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
