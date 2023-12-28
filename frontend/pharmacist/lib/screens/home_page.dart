import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_warehouse/data/dummy_data.dart';
import 'package:medicine_warehouse/screens/categories.dart';
import '../models/category.dart';
import 'package:medicine_warehouse/screens/medicine_details.dart';
import 'nav_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Category> foundCategories = [];
  @override
  void initState() {
    foundCategories = [...availableCategories];
    super.initState();
  }

  // function
  void _searchCategories(String enteredWord) {
    List<Category> suggestions = [];
    if (enteredWord.isEmpty) {
      suggestions = availableCategories;
    } else {
      suggestions = availableCategories
          .where(
            (category) => category.title.toLowerCase().contains(
                  enteredWord.toLowerCase(),
                ),
          )
          .toList();
    }
    setState(() {
      foundCategories = suggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade800,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
        title: Text(
          tr('homePage'),
          style: TextStyle(
            fontFamily: 'Tajawal', color: Colors.white
          ),
          // style: GoogleFonts.lato(color: Colors.white, fontSize: 22),
        ),
      ),
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
                  hintText: tr('search for a category'),
                  hintStyle: const TextStyle(fontFamily: 'Messiri'),
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
                onChanged: (value) => _searchCategories(value),
              ),
            ),
          ),
          Expanded(
            child: CategoriesScreen(foundCategories: foundCategories),
          )
        ],
      ),
    );
  }
}
