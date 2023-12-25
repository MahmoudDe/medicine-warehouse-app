import 'package:flutter/material.dart';
import 'package:warehouse_owner_app/Server/server.dart';

import '../classes/Medicine.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<String> statusOptions = ['Pending', 'Accepted', 'Rejected'];
  List<dynamic> orders = []; // Initialize orders as empty
  Map<int, List<dynamic>> orderItems = {}; // Initialize order items as empty
  Map<int, Medicine> medicines = {}; // Initialize medicines as empty
  bool isLoading = true; // Initialize loading state as true

  @override
  void initState() {
    super.initState();
    fetchOrdersAndMedicines();
  }

  Future<void> fetchOrdersAndMedicines() async {
    orders = await Server().getOrders(); // Fetch orders
    for (var order in orders) {
      orderItems[order['id']] = await Server()
          .getOrderItems(order['id']); // Fetch order items for each order
    }
    List<Medicine> medicineList =
        await Server().getMedicines(); // Fetch medicines
    for (var medicine in medicineList) {
      medicines[medicine.id] =
          medicine; // Store medicines in a map for easy access
    }
    setState(() {
      isLoading = false; // Set loading state to false after fetching data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.orangeAccent, size: 28),
        title: const Text('Pharmacist Orders',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.cyan.shade800,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon press
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while waiting for server response
          : orders.isEmpty
              ? const AlertDialog(
                  // Show dialog if orders are empty
                  title: Text('No Orders'),
                  content: Text('There are currently no orders.'),
                )
              : Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      color: Colors.grey,
                      child: ListView.builder(
                        itemCount:
                            orders.length, // Use the length of your orders list
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.all(10),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15), // More circular border
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.medical_services,
                                color: Colors.cyan.shade800,
                                size: 40,
                              ),
                              title: Text('Order #${orders[index]['id']}',
                                  style: TextStyle(
                                      color: Colors.cyan.shade800,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24)), // Increase text size
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Order id:  ${orders[index]['id']}',
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 20)),
                                  // Increase text size
                                  Text('Status: ${orders[index]['status']}',
                                      style: const TextStyle(
                                          color: Colors.orangeAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  ...orderItems[orders[index]['id']]?.map(
                                          (item) => Text(
                                              'Medicine name: ${medicines[item['medicine_id']]?.scientificName ?? 'Unknown'}\n'
                                                  'Medicine_id: ${item['medicine_id']}\n Quantity: ${item['quantity']}',
                                              style: const TextStyle(
                                                  fontSize: 24,color: Colors.black
                                              )
                                              )) ??
                                      [],
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors
                                              .green,
                                        ),
                                        onPressed: () async {
                                          await Server()
                                              .acceptOrder(orders[index]['id']);
                                          orders = await Server().getOrders();
                                          setState(() {});
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Order Accepted'),
                                                content: Text(
                                                    'Order #${orders[index]['id']} has been accepted.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('OK'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: const Text(
                                          'Accept Order',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      // Add some space between the buttons
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        onPressed: () async {
                                          await Server().rejectOrder(orders[index]['id']);orders = await Server().getOrders();
                                          setState(() {}
                                          );
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Order Rejected'),
                                                content: Text(
                                                    'Order #${orders[index]['id']} has been rejected.'),
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
                                        },
                                        child: const Text('Reject Order',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
    );
  }
}
