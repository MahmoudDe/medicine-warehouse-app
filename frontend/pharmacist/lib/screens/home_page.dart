import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_warehouse/screens/nav_bar.dart';
import 'package:medicine_warehouse/screens/categories.dart';

// Badr's screen

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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


          

          // Badr's Cards




        ],
      ),
    );
  }
}
