import 'package:kantin/models/cart_model.dart';

class TransactionModel {
  int id;
  int userId;
  String status;
  String payment;
  int totalPrice;
  int subTotalItem;
  List<CartModel> items;
  DateTime createdAt;
  DateTime updatedAt;

  TransactionModel({
    this.id,
    this.userId,
    this.status,
    this.payment,
    this.totalPrice,
    this.subTotalItem,
    this.items,
    this.createdAt,
    this.updatedAt,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['users_id'];
    status = json['status'];
    payment = json['payment'];
    totalPrice = json['total_price'];
    subTotalItem = json['sub_total_item'];
    if (json['items'] == null) {
      items = null;
    } else {
      items =
          List<CartModel>.from(json['items'].map((x) => CartModel.fromJson(x)));
    }
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'users_id': userId,
      'status': status,
      'payment': payment,
      'total_price': totalPrice,
      'sub_total_item': subTotalItem,
      'items': List<dynamic>.from(items.map((x) => x.toJson())),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}
