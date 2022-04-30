import 'package:kantin/models/product_model.dart';

class OrderModel {
  int id;
  ProductModel product;
  int quantity;
  int transactionsId;

  OrderModel({
    this.id,
    this.product,
    this.quantity,
    this.transactionsId,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductModel.fromJson(json['product']);
    quantity = json['quantity'];
    transactionsId = json['transactions_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product,
      'quantity': quantity,
      'transactions_id': transactionsId,
    };
  }

  int getTotalPrice() {
    return PricePajak() * quantity;
  }

  int PricePajak() {
    return product.price + 3000;
  }
}
