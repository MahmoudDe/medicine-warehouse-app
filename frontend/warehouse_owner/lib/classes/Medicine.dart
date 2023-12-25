class Medicine {
  int id;
  int categoriesId;
  String scientificName;
  String commercialName;
  String category;
  String manufacturer;
  int quantity;
  DateTime expiryDate;
  double price;
  String? image;

  Medicine({
    required this.id,
    required this.categoriesId,
    required this.scientificName,
    required this.commercialName,
    required this.category,
    required this.manufacturer,
    required this.quantity,
    required this.expiryDate,
    required this.price,
    this.image,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      categoriesId: json['categories_id'],
      scientificName: json['scientific_name'],
      commercialName: json['commercial_name'],
      category: json['category'],
      manufacturer: json['manufacturer'],
      quantity: json['quantity'],
      expiryDate: DateTime.parse(json['expiry_date']),
      price: double.tryParse(json['price']) ?? 0.0,
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categories_id': categoriesId,
      'scientific_name': scientificName,
      'commercial_name': commercialName,
      'category': category,
      'manufacturer': manufacturer,
      'quantity': quantity,
      'expiry_date': expiryDate.toIso8601String(),
      'price': price,
      'image': image,
    };
  }
}


// class Medicine {
//   int id;
//   int categoriesId;
//   String scientificName;
//   String commercialName;
//   String category;
//   String manufacturer;
//   int quantity;
//   DateTime expiryDate;
//   double price;
//
//   Medicine({
//     required this.id,
//     required this.categoriesId,
//     required this.scientificName,
//     required this.commercialName,
//     required this.category,
//     required this.manufacturer,
//     required this.quantity,
//     required this.expiryDate,
//     required this.price,
//   });
//
//   factory Medicine.fromJson(Map<String, dynamic> json) {
//     return Medicine(
//       id: json['id'],
//       categoriesId: json['categories_id'],
//       scientificName: json['scientific_name'],
//       commercialName: json['commercial_name'],
//       category: json['category'],
//       manufacturer: json['manufacturer'],
//       quantity: json['quantity'],
//       expiryDate: DateTime.parse(json['expiry_date']),
//       price: json['price'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'categories_id': categoriesId,
//       'scientific_name': scientificName,
//       'commercial_name': commercialName,
//       'category': category,
//       'manufacturer': manufacturer,
//       'quantity': quantity,
//       'expiry_date': expiryDate.toIso8601String(),
//       'price': price,
//     };
//   }
// }
