import 'package:medicine_warehouse/models/category.dart';
import 'package:medicine_warehouse/models/medicine.dart';

const availableCategories = [
  Category(
    id: 'c1',
    title: 'Medicines',
    imageUrl: 'assets/images/1.png',
  ),
  Category(
    id: 'c2',
    title: 'Skin Care',
    imageUrl: 'assets/images/2.png',
  ),
  Category(
    id: 'c3',
    title: 'Hair Care',
    imageUrl: 'assets/images/3.png',
  ),
  Category(
    id: 'c4',
    title: 'Daily Care',
    imageUrl: 'assets/images/4.png',
  ),
  Category(
    id: 'c5',
    title: 'Mother & Kid',
    imageUrl: 'assets/images/5.png',
  ),
  Category(
    id: 'c6',
    title: 'Vitamins',
    imageUrl: 'assets/images/6.png',
  ),
  Category(
    id: 'c7',
    title: 'Medical Supplies',
    imageUrl: 'assets/images/7.png',
  ),
  Category(
    id: 'c8',
    title: 'Make-Up',
    imageUrl: 'assets/images/8.png',
  ),
  Category(
    id: 'c9',
    title: 'Shampoo & Craims',
    imageUrl: 'assets/images/9.png',
  ),
];

const availableMedicines = [
  Medicine(
    medicineName: 'ParaCetamol',
    description: [
      'Paracetamol is a commonly used medicine that can help treat pain.',
      'Paracetamol is reduce a high temperature.'
          't’s safe for most people to take and side effects are rare.',
    ],
    categories: [
      'c1',
      'c2',
    ],
    price: 12,
    imageUrl:
        'https://www.peakpharmacy.co.uk/uploads/images/products/large/16814691621605695959-07309400.jpg',
  ),
  Medicine(
    medicineName: 'Omega3',
    description: [
      'Paracetamol is a commonly used medicine that can help treat pain.',
      'Paracetamol is reduce a high temperature.'
          't’s safe for most people to take and side effects are rare.',
    ],
    categories: [
      'c3',
    ],
    price: 12,
    imageUrl:
        'https://www.peakpharmacy.co.uk/uploads/images/products/large/16814691621605695959-07309400.jpg',
  ),
  Medicine(
    medicineName: 'B12',
    description: [
      'Paracetamol is a commonly used medicine that can help treat pain.',
      'Paracetamol is reduce a high temperature.'
          't’s safe for most people to take and side effects are rare.',
    ],
    categories: [
      'c4',
    ],
    price: 12,
    imageUrl:
        'https://www.peakpharmacy.co.uk/uploads/images/products/large/16814691621605695959-07309400.jpg',
  ),
  Medicine(
    medicineName: 'vit D',
    description: [
      'Paracetamol is a commonly used medicine that can help treat pain.',
      'Paracetamol is reduce a high temperature.'
          't’s safe for most people to take and side effects are rare.',
    ],
    categories: [
      'c5',
    ],
    price: 12,
    imageUrl:
        'https://www.peakpharmacy.co.uk/uploads/images/products/large/16814691621605695959-07309400.jpg',
  ),
  Medicine(
    medicineName: 'Iron',
    description: [
      'Paracetamol is a commonly used medicine that can help treat pain.',
      'Paracetamol is reduce a high temperature.'
          't’s safe for most people to take and side effects are rare.',
    ],
    categories: [
      'c6',
    ],
    price: 12,
    imageUrl:
        'https://www.peakpharmacy.co.uk/uploads/images/products/large/16814691621605695959-07309400.jpg',
  ),
  Medicine(
    medicineName: 'vit E',
    description: [
      'Paracetamol is a commonly used medicine that can help treat pain.',
      'Paracetamol is reduce a high temperature.'
          't’s safe for most people to take and side effects are rare.',
    ],
    categories: [
      'c7',
    ],
    price: 12,
    imageUrl:
        'https://www.peakpharmacy.co.uk/uploads/images/products/large/16814691621605695959-07309400.jpg',
  ),
  Medicine(
    medicineName: 'vit K',
    description: [
      'Paracetamol is a commonly used medicine that can help treat pain.',
      'Paracetamol is reduce a high temperature.'
          't’s safe for most people to take and side effects are rare.',
    ],
    categories: [
      'c8',
    ],
    price: 12,
    imageUrl:
        'https://www.peakpharmacy.co.uk/uploads/images/products/large/16814691621605695959-07309400.jpg',
  ),
  Medicine(
    medicineName: 'vit c',
    description: [
      'Paracetamol is a commonly used medicine that can help treat pain.',
      'Paracetamol is reduce a high temperature.'
          't’s safe for most people to take and side effects are rare.',
    ],
    categories: [
      'c9',
    ],
    price: 12,
    imageUrl:
        'https://www.peakpharmacy.co.uk/uploads/images/products/large/16814691621605695959-07309400.jpg',
  ),
];
