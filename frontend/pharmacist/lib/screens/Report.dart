import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
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



  Future<int?> getUserIdFromSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId');
      return userId;
    } catch (e) {
      print('Error retrieving user ID: $e');
      return null;
    }
  }

  Future<void> printTokenAndUserId() async {
    final token = await getToken();
    final userId = await getUserIdFromSharedPreferences();

    print('Token: $token');
    print('User ID: $userId');
  }



  Future<void> fetchData() async {
    if (startDate != null && endDate != null) {
      final dio = Dio();
      final baseUrl = 'http://localhost:8000/api'; // Replace with your base URL
      print(printTokenAndUserId());

      try {
        final token = await getToken();
        final userId = await getUserIdFromSharedPreferences(); // Get user ID from SharedPreferences
        print(printTokenAndUserId());

        if (token != null && userId != null) {
          dio.options.headers['Authorization'] = 'Bearer $token';

          final totalResponse = await dio.post(
            '$baseUrl/total',
            data: {
              'startDate': startDate!.toString(),
              'endDate': endDate!.toString(),
              'userId': userId,
            },
          );

          final totalData = totalResponse.data;
          final totalAmount = totalData['total_amount']['total_price'];
          final email = totalData['email '];

          final quantityResponse = await dio.post(
            '$baseUrl/quantity',
            data: {
              'startDate': startDate!.toString(),
              'endDate': endDate!.toString(),
              'userId': userId,
            },
          );

          final quantityData = quantityResponse.data;
          final totalQuantity = quantityData['quantity']['total_quantity'];

          print('Total Price: $totalAmount');
          print('Email: $email');
          print('Total Quantity: $totalQuantity');
          print(printTokenAndUserId());

          setState(() {
            orders.add('Total Price: $totalAmount');
            orders.add('Email: $email');
            orders.add('Total Quantity: $totalQuantity');
          });
        } else {
          print('Token or UserID is null');
        }
      } catch (e) {
        print('Error fetching data: $e');
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white,),
              onPressed: () {
                Navigator.pushNamed(context, '/main');
              },
            );
          },
        ),
        title: Text('Order Report', style: TextStyle(color: Colors.white, fontFamily: 'Avenir'),),
        backgroundColor: Colors.cyan.shade700,
      ),
      body: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(width: 2, color: Colors.grey)
        ),
        color: Colors.white70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: Text('Order Reports', style: TextStyle(color: Colors.cyan.shade700,fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'Avenir'),)),
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
                      backgroundColor: Colors.orange.shade200,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Avenir',
                      ),
                      side: BorderSide(
                        width: 2.0,
                        style: BorderStyle.solid,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    child: Text(
                      'Start Date: ${startDate != null ? DateFormat.yMd().format(startDate!) : 'Select'}',
                      style: TextStyle(color: Colors.white),
                    ),
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
                      backgroundColor: Colors.orange.shade200,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Avenir',
                      ),
                      side: BorderSide(
                        width: 2.0,
                        style: BorderStyle.solid,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    child: Text(
                      'End Date: ${endDate != null ? DateFormat.yMd().format(endDate!) : 'Select'}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25),
              child: ElevatedButton(
                onPressed: fetchData,
                child: Text('Fetch Data',style: TextStyle(fontFamily: 'Avenir', color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade400,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Avenir',
                  ),
                  side: BorderSide(width: 2.0,style: BorderStyle.solid,color: Colors.grey),

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
                        color: Colors.white,
                        elevation: 4,
                        child: ListTile(
                          title: Text(
                            orders[index],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
