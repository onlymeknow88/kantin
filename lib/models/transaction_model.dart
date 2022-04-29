import 'package:kantin/models/cart_model.dart';

class TransactionModel {
  int id;
  String status;
  int totalPrice;
  List<CartModel> items;

  TransactionModel({
    this.id,
    this.status,
    this.totalPrice,
    this.items,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    totalPrice = json['total_price'];
    items = json['items']
        .map<CartModel>((item) => CartModel.fromJson(item))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'total_price': totalPrice,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
