import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_warehouse/screens/NavBar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
            backgroundColor: Colors.cyan.shade800,
            title: Text(
              'Home Page',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 24,
              ),
            )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
                child: TextField(
                                decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {},
                ),
                hintText: 'Search...',
                border: InputBorder.none,
                                ),
                              ),
            ),
          ),
        ],
      )
    );
  }
}

