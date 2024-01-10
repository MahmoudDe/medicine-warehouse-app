import 'package:flutter/material.dart';
import 'package:warehouse_owner_app/Server/server.dart';

import '../classes/Medicine.dart';
import 'Report.dart';

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
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
        title: const Text('Pharmacist Orders',
            style: TextStyle(color: Colors.white, fontFamily: 'Avenir', fontSize: 25 ), textAlign: TextAlign.center,),
        backgroundColor: Colors.cyan.shade800,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.replay_10_outlined),
            onPressed: () {
              // Handle notification icon press
              Navigator.pushNamed(context, '/report');
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(color: Colors.orangeAccent,),
      )
          : orders.isEmpty
          ? const AlertDialog(
        title: Text('No Orders'),
        content: Text('There are currently no orders.'),
      )
          : Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Card(
                color: Colors.grey,
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.medical_services,
                          color: Colors.cyan.shade800,
                          size: 40,
                        ),
                        title: Text(
                          'Order ${orders[index]['id']}',
                          style: TextStyle(
                            color: Colors.cyan.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            fontFamily: 'Avenir'
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            Text(
                              'Status: ${orders[index]['status']}',
                              style: const TextStyle(
                                color: Colors.orangeAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            ...orderItems[orders[index]['id']]
                                ?.map(
                                  (item) => Text(
                                'Medicine name: ${medicines[item['medicine_id']]?.scientificName ?? 'Unknown'}\n'
                                    'Medicine_id: ${item['medicine_id']}\n Quantity: ${item['quantity']}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ),
                            ) ??
                                [],
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  onPressed: () async {
                                    await Server().acceptOrder(
                                        orders[index]['id']);
                                    orders =
                                    await Server().getOrders();
                                    setState(() {});
                                    showDialog(
                                      context: context,
                                      builder:
                                          (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              'Order Accepted'),
                                          content: Text(
                                              'Order #${orders[index]['id']} has been accepted.'),
                                          actions: <Widget>[
                                            TextButton(
                                              child:
                                              const Text('OK'),
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
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () async {
                                    var rejectedOrder =
                                    orders[index];
                                    await Server().rejectOrder(
                                        rejectedOrder['id']);
                                    setState(() {
                                      orders.removeAt(index);
                                    });
                                    showDialog(
                                      context: context,
                                      builder:
                                          (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              'Order Rejected'),
                                          content: Text(
                                              'Order #${rejectedOrder['id']} has been rejected.'),
                                          actions: <Widget>[
                                            TextButton(
                                              child:
                                              const Text('OK'),
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
                                    'Reject Order',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),const SizedBox(width: 10),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                  ),
                                  onPressed: () async {
                                    var recievedOrder =
                                    orders[index];
                                    await Server().recieveOrder(
                                        recievedOrder['id']);

                                    showDialog(
                                      context: context,
                                      builder:
                                          (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              'Order Recieved'),
                                          content: Text(
                                              'Order #${recievedOrder['id']} has been recieved.'),
                                          actions: <Widget>[
                                            TextButton(
                                              child:
                                              const Text('OK'),
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
                                    'Recieved',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
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
          Expanded(
            child: OrderReportScreen(),
          ),
        ],
      ),
    );
  }
}
