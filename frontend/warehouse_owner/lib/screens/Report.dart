import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderReportScreen extends StatefulWidget {
  @override
  _OrderReportScreenState createState() => _OrderReportScreenState();
}

class _OrderReportScreenState extends State<OrderReportScreen> {
  DateTime? startDate;
  DateTime? endDate;
  List<String> orders = [];
  int userId = 0;

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Function to fetch total and quantity data
  TextEditingController userIdController = TextEditingController();

  Future<void> fetchData() async {
    if (startDate != null && endDate != null) {
      final dio = Dio();
      final baseUrl = 'http://localhost:8000/api'; // Replace with your base URL

      try {
        final token = await getToken();

        if (token != null) {
          dio.options.headers['Authorization'] = 'Bearer $token';

          // Get the user ID from the text input field
          final userId = userIdController.text;

          final totalResponse = await dio.post(
            '$baseUrl/total',
            data: {
              'startDate': startDate!.toString(),
              'endDate': endDate!.toString(),
              'userId': userId, // Use the user ID from the input field
            },
          );

          // Extracting data from the total response
          final totalData = totalResponse.data;
          final totalAmount = totalData['total_amount']['total_price'];
          final email = totalData['email '];

          // Fetch quantity data
          final quantityResponse = await dio.post(
            '$baseUrl/quantity',
            data: {
              'startDate': startDate!.toString(),
              'endDate': endDate!.toString(),
              'userId': userId, // Use the user ID from the input field
            },
          );

          final quantityData = quantityResponse.data;
          final totalQuantity = quantityData['quantity']['total_quantity'];

          print('Total Price: $totalAmount');
          print('Email: $email');
          print('Total Quantity: $totalQuantity');

          setState(() {
            orders.add('Total Price: $totalAmount');
            orders.add('Email: $email');
            orders.add('Total Quantity: $totalQuantity');
          });
        } else {
          print('Token is null');
        }
      } catch (e) {
        print('Error fetching data: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Order Reports',
                style: TextStyle(
                  color: Colors.cyan.shade700,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Avenir',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
            child: TextField(
              controller: userIdController,
              onChanged: (value) {
                setState(() {
                  userId = int.tryParse(value) ?? 0;
                });
              },
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: 'Roboto',
              ),
              cursorColor: Colors.cyan.shade700,
              decoration: InputDecoration(
                hintText: 'Enter User ID',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                labelText: 'User ID',
                labelStyle: TextStyle(
                  color: Colors.orange, // Label text color
                  fontWeight: FontWeight.bold, // Label text weight
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan.shade700), // Border color
                  borderRadius: BorderRadius.circular(.0), // Border radius
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: Icon(
                  Icons.person, // Icon leading the text field
                  color: Colors.orange, // Icon color
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear, // Clear icon
                    color: Colors.grey, // Clear icon color
                  ),
                  onPressed: () {
                    userIdController.clear(); // Clears the text field
                    setState(() {
                      userId = 0; // Reset userId to default value
                    });
                  },
                ),
              ),
            ),

          ),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    setState(() {
                      startDate = date;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange.shade200,
                    onPrimary: Colors.white,
                    textStyle: TextStyle(
                      fontFamily: 'Avenir',
                    ),
                    side: BorderSide(
                      width: 2.0,
                      style: BorderStyle.solid,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  child: Text(
                      'Start Date: ${startDate?.toString() ?? 'Select'}'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    setState(() {
                      endDate = date;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange.shade200,
                    onPrimary: Colors.white,
                    textStyle: TextStyle(
                      fontFamily: 'Avenir',
                    ),
                    side: BorderSide(
                      width: 2.0,
                      style: BorderStyle.solid,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  child: Text('End Date: ${endDate?.toString() ?? 'Select'}'),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ElevatedButton(
              onPressed: fetchData,
              child: Text(
                'Fetch Data',
                style: TextStyle(fontFamily: 'Avenir', color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade400,
                onPrimary: Colors.white,
                textStyle: TextStyle(
                  fontFamily: 'Avenir',
                ),
                side: BorderSide(
                  width: 2.0,
                  style: BorderStyle.solid,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          // Add some space between the input section and the cards
          if (orders.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        title: Text(
                          orders[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Avenir',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
