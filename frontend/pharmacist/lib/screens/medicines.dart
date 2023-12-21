import 'package:flutter/material.dart';
import 'package:medicine_warehouse/models/medicine.dart';
import 'package:medicine_warehouse/widgets/medicine_item.dart';
import 'package:medicine_warehouse/screens/medicine_details.dart';

class MedicinesScreen extends StatelessWidget {
  MedicinesScreen({
    required this.title,
    required this.medicines,

    super.key,
  });
  final String? title;
  final List<Medicine> medicines;

  // void _onSelectedMedicine(BuildContext context, Medicine medicine) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (ctx) => MedicineDetailsScreen(
  //         medicine: medicine,
  //         onToggleFavorite: onToggleFavorite,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: medicines.length,
      itemBuilder: (ctx, index) => Text(medicines[index].scientificName),
    );

    content = MedicineItem(
      medicines: medicines, onToggleFavorite: (Medicine medicine) {  },

    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
