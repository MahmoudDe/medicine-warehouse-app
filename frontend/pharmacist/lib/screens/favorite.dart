import 'package:flutter/material.dart';
import 'package:medicine_warehouse/data/dummy_data.dart';
import 'package:medicine_warehouse/models/medicine.dart';
import 'package:medicine_warehouse/screens/medicines.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() {
    return _FavoriteScreen();
  }
}

class _FavoriteScreen extends State<FavoriteScreen> {
  final List<Medicine> _FavoriteMedicines = [];

  void _toggleMedicineFavoriteStatus(Medicine medicine) {
    setState(() {
      _FavoriteMedicines.add(medicine);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MedicinesScreen(
      title: 'Favorites',
      medicines: favoritList,
    );
  }
}
