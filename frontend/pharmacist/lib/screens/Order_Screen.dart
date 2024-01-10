import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../Provider/cart_model.dart';
import '../models/Order.dart';
import '../models/medicine.dart';
import '../server/server.dart';


class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final Server server = Server(); // replace with your Server instance
  late Future<List<dynamic>> futureOrders;

  @override
  void initState() {
    super.initState();
    futureOrders = server.getOrdersForUser(); // fetch orders for user
  }

  Future<void> _refreshOrders() async {
    setState(() {
      futureOrders = server.getOrdersForUser(); // fetch orders for user
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: RefreshIndicator(
        onRefresh: _refreshOrders,
        child: FutureBuilder<List<dynamic>>(
          future: futureOrders,
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: Colors.orangeAccent));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              if (snapshot.data?.isEmpty ?? true) {
                return Center(child: Text('No orders found'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    var order = snapshot.data?[index];
                    var items = order?['items'] as List<dynamic>?;

                    if (items != null && items.isNotEmpty) {
                      var medicine = Medicine.fromJson(items[0]['medicine']);
                      var orderObject = Order.fromJson(order);

                      print('Medicine Name in ListView.builder: ${medicine.scientificName}');
                      print('Medicine Price in ListView.builder: ${medicine.price}');

                      return OrderItemTile(medicine, orderObject);
                    } else {
                      return Container();
                    }
                  },
                );
              }
            }
          },
        ),
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
    print('Medicine Name in OrderItemTile: ${item.scientificName}');
    print('Medicine Price in OrderItemTile: ${order.totalAmount}');

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
            leading: Image.asset('assets/images/medicine.png', width: 90,fit: BoxFit.cover,),
            title: Text(
              item.scientificName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('Order Date: ${order.date}\nCategory: ${item.category} Quantity: ${item.quantity}\nMedicine Price: ${item.price}\nTotal Cost: ${order.totalAmount}'),
            trailing: Container(
              width: 90,
              height: 40,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: _getOrderStatusColor(order.status),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(
                child: Text(
                  order.status,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
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
      case 'Preparing':
        return Colors.green;
      case 'Processing':
        return Colors.orange;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
