// class Medicine {
//   final String imageUrl;
//   final String name;
//   final String category;
//   final double price;
//   int quantity;
//
//   Medicine({
//     required this.imageUrl,
//     required this.name,
//     required this.category,
//     required this.price,
//     required this.quantity, // Make quantity required
//   });
// }

class Medicine {
  final String scientificName;
  final String commercialName;
  final String category;
  final String manufacturer;
  int quantity;
  final DateTime expiryDate;
  final double price;

  Medicine({
    required this.scientificName,
    required this.commercialName,
    required this.category,
    required this.manufacturer,
    required this.quantity,
    required this.expiryDate,
    required this.price,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      scientificName: json['scientific_name'],
      commercialName: json['commercial_name'],
      category: json['category'],
      manufacturer: json['manufacturer'],
      quantity: json['quantity'],
      expiryDate: DateTime.parse(json['expiry_date']),
      price: json['price'].toDouble(),
    );
  }
}
