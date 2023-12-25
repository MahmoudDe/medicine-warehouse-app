// ignore_for_file: file_names

class Medicine {
  final int medicineId;
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
      );

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      json['medicine_id']?? 1,
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
    );
  }
  @override
  String toString() {
    return 'Medicine: $medicineName, $scientificName, $tradeName, $category, $manufacturer, $expiryDate, $description';
  }
}
