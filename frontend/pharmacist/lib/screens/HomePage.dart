import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_warehouse/screens/medicine_details.dart';
import 'package:medicine_warehouse/screens/nav_bar.dart';

import '../models/Medicine.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Medicine> medicines = [
    Medicine(1000, 30, 'Omega', 'Omg', 'baby', '12/12/2024', 'IbnZaher', '....',
        'assets/images/Medicine 1.jpg',
        medicineName: 'Omega'),
    Medicine(1000, 30, 'Omega', 'Omg', 'baby', '12/12/2024', 'IbnZaher', '....',
        'assets/images/Medicine 1.jpg',
        medicineName: 'Omega'),
    Medicine(1000, 30, 'Omega', 'Omg', 'baby', '12/12/2024', 'IbnZaher', '....',
        'assets/images/Medicine 1.jpg',
        medicineName: 'Omega'),
    Medicine(1000, 30, 'Omega', 'Omg', 'baby', '12/12/2024', 'IbnZaher', '....',
        'assets/images/Medicine 1.jpg',
        medicineName: 'Omega'),
    Medicine(1000, 30, 'Omega', 'Omg', 'baby', '12/12/2024', 'IbnZaher', '....',
        'assets/images/Medicine 1.jpg',
        medicineName: 'Omega'),
  ];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
          backgroundColor: Colors.cyan.shade800,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.white, size: 28),
          title: Text('Home Page',
              style: GoogleFonts.lato(color: Colors.white, fontSize: 22))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                    },
                  ),
                  hintText: 'Search...',
                  hintStyle: const TextStyle(fontFamily: 'Avenir'),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.cyan.shade700),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.orange),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: medicines.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MedicineDetailsScreen( medicine: medicines[index],),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            medicines[index].image,
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            medicines[index].scientificName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${medicines[index].price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
