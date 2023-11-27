import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_warehouse/screens/NavBar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
            backgroundColor: Colors.cyan.shade800,
            title: Text(
              'Home Page',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 27,
              ),
            )),
      ),
      Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Center(
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
          )))
    ]);
  }
}
