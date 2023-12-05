import 'package:flutter/material.dart';

import '../models/medicine.dart';

class MedicineItem extends StatelessWidget {
  const MedicineItem(
      {required this.medicine, required this.onSelectedMedicine, super.key});
  final Medicine medicine;
  final void Function() onSelectedMedicine;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectedMedicine,
      child: Card(
        child: Image.network(medicine.image),
      ),
    );
  }
}
