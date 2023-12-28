// ignore_for_file: file_names

class Medicine {
   int medicineId;
  int quantity;
  final double price;
  bool isFavorite;
  final String scientificName;
  final String tradeName;
  final String category;
  final String manufacturer;
  final String image;
  final String expiryDate;
  final String description;
  final String medicineName;
   int maxQuantity;

  Medicine(
      this.medicineId,
      this.isFavorite,
      this.price,
      this.quantity,
      this.scientificName,
      this.tradeName,
      this.category,
      this.manufacturer,
      this.expiryDate,
      this.description,
      this.image,
      this.medicineName,
      this.maxQuantity,

      );

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      json['id'],
      json['isFavorite'] ?? false,
      double.parse(json['price']),
      json['quantity'],
      json['scientific_name'] ?? 'Medicine scientific name',
      json['tradeName'] ?? '',
      json['category'] ?? 'baby',
      json['manufacturer'] ?? '',
      json['expiryDate'] ?? '',
      json['description'] ?? '',
      json['image'] ?? 'assets/images/Medicine 1.jpg',
      json['medicineName'] ?? 'Medicine',
      json['quantity'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Medicine: $medicineName, $scientificName, $tradeName, $category, $manufacturer, $expiryDate, $description';
  }
}
