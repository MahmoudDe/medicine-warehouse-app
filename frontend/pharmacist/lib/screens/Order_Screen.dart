import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../Provider/cart_model.dart';
import '../models/Order.dart';
import '../models/medicine.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/main');
          },
        ),
        title: Row(
          children: [
            Text('Order Page', style: TextStyle(
              fontSize: 25,
              color: Colors.white
            ),),
          ],
        ),
        backgroundColor: Colors.cyan.shade700,
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              return OrderItemTile(cart.items[index], Order(orderId: 1, userId: 1, status: 'pending', date: ''));
            },
          );
        },
      ),
    );
  }
}
class OrderItemTile extends StatelessWidget {
  final Medicine item;
  final Order order;

  OrderItemTile(this.item, this.order);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.grey.shade200,
        elevation: 0.0,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.orangeAccent,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            leading: Icon(
              _getOrderStatusIcon(order.status), // replace with function to get icon based on status
              color: Colors.orangeAccent,
              size: 50,
            ),
            title: Text(
              item.scientificName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('Quantity: ${item.quantity}\nPrice: ${item.price}'),
            trailing: Container(
              width: 80,
              height: 40,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: _getOrderStatusColor(order.status), // replace with function to get color based on status
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(
                child: Text(
                  order.status, // replace with actual status
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getOrderStatusIcon(String status) {
    // replace with your own logic to return different icons based on status
    switch (status) {
      case 'Delivered':
        return Icons.check_circle;
      case 'Processing':
        return Icons.hourglass_empty;
      case 'Cancelled':
        return Icons.cancel;
      default:
        return Icons.ac_unit_outlined;
    }
  }

  Color _getOrderStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return Colors.green;
      case 'Processing':
        return Colors.orange;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.cyan.shade700;
    }
  }
}
