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
      orderId: json['order_id'],
      userId: json['user_id'],
      status: json['status'],
      date: json['date'],
      totalAmount: json['total_amount'],
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
