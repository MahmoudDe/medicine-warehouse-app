import 'package:flutter/material.dart';
import 'package:medicine_warehouse/data/dummy_data.dart';
import 'package:medicine_warehouse/models/medicine.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_warehouse/server/server.dart';
import 'package:medicine_warehouse/widgets/medicine_item.dart';
import 'package:medicine_warehouse/screens/medicine_details.dart';

class MedicinesScreen extends StatefulWidget {
  MedicinesScreen({
    required this.title,
    required this.medicines,
    super.key,
  });
  final String? title;
  final List<Medicine> medicines;

  @override
  State<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {
  final TextEditingController _controller = TextEditingController();

  List<Medicine> foundMedicines = [];


  @override
  void initState() {
    super.initState();
    foundMedicines = widget.medicines;
  }


  // function
  void _searchMedicines(String enteredWord) {
    List<Medicine> suggestions = [];
    if (enteredWord.isEmpty) {
      suggestions = widget.medicines;
    } else {
      suggestions = widget.medicines
          .where(
            (medicine) => medicine.scientificName.toLowerCase().contains(
                  enteredWord.toLowerCase(),
                ),
          )
          .toList();
    }
    setState(() {
      foundMedicines = suggestions;
    });
  }

  // void _onSelectedMedicine(BuildContext context, Medicine medicine) {
  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: foundMedicines.length,
      itemBuilder: (ctx, index) => Text(foundMedicines[index].scientificName),
    );
    if (foundMedicines.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh...nothing here!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Try selecting a different category',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      );
    } else {
      content = MedicineItem(
        medicines: foundMedicines,
        onToggleFavorite: (Medicine medicine) {},
      );
    }
    if (widget.title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade800,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
        title: Text(
          widget.title!,
          style: GoogleFonts.lato(color: Colors.white, fontSize: 22),
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
                  hintText: 'Search for a medicine...',
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
                onChanged: (value) => _searchMedicines(value),
              ),
            ),
          ),
          Expanded(
            child: content,
          ),
        ],
      ),
    );
  }
}
