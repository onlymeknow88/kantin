class TransactionModel {
  int id;

  String status;
  int totalPrice;
  // List<CartModel> items;
  // DateTime createdAt;
  // DateTime updatedAt;

  TransactionModel({
    this.id,
    this.status,
    this.totalPrice,
    // this.items,
    // this.createdAt,
    // this.updatedAt,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    totalPrice = json['total_price'];
    // items:
    // (json['items'] as List)
    //     .map<CartModel>((item) => CartModel.fromJson(item))
    // .toList();
    // createdAt = DateTime.parse(json['created_at']);
    // updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'total_price': totalPrice,
      // 'items': items.map((item) => item.toJson()).toList(),
      // 'created_at': createdAt.toString(),
      // 'updated_at': updatedAt.toString(),
    };
  }
}
