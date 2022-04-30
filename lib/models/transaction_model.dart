import 'package:kantin/models/order_model.dart';

class TransactionModel {
  int id;
  String status;
  String payment;
  int totalPrice;
  List<OrderModel> items;
  DateTime createdAt;
  DateTime updatedAt;

  TransactionModel({
    this.id,
    this.status,
    this.payment,
    this.totalPrice,
    this.items,
    this.createdAt,
    this.updatedAt,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    payment = json['payment'];
    totalPrice = json['total_price'];
    if (json['items'] == null) {
      items = null;
    } else {
      items = List<OrderModel>.from(
          json['items'].map((x) => OrderModel.fromJson(x)));
    }
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'payment': payment,
      'total_price': totalPrice,
      'items': List<dynamic>.from(items.map((x) => x.toJson())),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }

  int PajakBayar() {
    return totalPrice + 3000;
  }
}
