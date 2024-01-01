class Order {
  final int orderId;
  final int userId;
  final String status;
  final String date;
  double totalAmount;

  Order({
    required this.orderId,
    required this.userId,
    required this.status,
    required this.date,
    this.totalAmount = 0.0,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['order_id'] ?? 1, // default value is 0
      userId: json['user_id'] ?? 1, // default value is 0
      status: json['status'] ?? 'waiting for warehouse', // provide a default value
      date: json['date'] ?? 'default date', // provide a default value
      totalAmount: double.parse(json['total_amount'] ?? '0.0'), // default value is 0.0
    );
  }




  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'user_id': userId,
      'status': status,
      'date': date,
      'total_amount': totalAmount,
    };
  }
}
