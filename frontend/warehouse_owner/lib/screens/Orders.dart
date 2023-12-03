import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../Provider/Medicine_Provider.dart';
import '../classes/Order.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}
class _OrderPageState extends State<OrderPage> {
  List<String> statusOptions = ['Pending', 'Accepted', 'Rejected'];
  List<String> orderStatus = List.filled(10, 'Pending'); // Initialize all orders as 'Pending'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.orangeAccent, size: 28),
        title: Text('Pharmacist Orders', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.cyan.shade800,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon press
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width/2,
          child: Card(
            color: Colors.grey,
            child: ListView.builder(
              itemCount: 10, // Replace with your list length
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // More circular border
                  ),
                  child: ListTile(
                    leading: Icon(Icons.medical_services, color: Colors.cyan.shade800,size: 40,),
                    title: Text('Order #${index + 1}', style: TextStyle(color: Colors.cyan.shade800, fontWeight: FontWeight.bold)), // Replace with your order title
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Details of Order #${index + 1}', style: TextStyle(color: Colors.grey)), // Replace with your order details
                        Text('Status: ${orderStatus[index]}', style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold)), // Display order status
                      ],
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          dropdownColor: Colors.grey.shade100,
                          value: orderStatus[index],
                          icon: Icon(Iconsax.arrow_circle_down, color: Colors.cyan),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.cyan, fontSize: 14),
                          onChanged: (String? newValue) {
                            setState(() {
                              orderStatus[index] = newValue!;
                              if (newValue == 'Accepted') {
                                // Decrease the quantity of the ordered medicine
                                // Replace 'Medicine Name' with the actual name of the medicine that was ordered
                                // Replace orderedQuantity with the actual quantity that was ordered
                                Provider.of<MedicineProvider>(context, listen: false).decreaseQuantity(order.medicineName, order.quantity);
                              }
                            });
                          },
                          items: statusOptions.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.cyan.shade800,
        onPressed: () {
          // Navigate to new order page
        },
      ),
    );
  }
}
