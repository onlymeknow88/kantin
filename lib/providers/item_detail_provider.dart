import 'package:flutter/material.dart';
import 'package:kantin/models/order_model.dart';
import 'package:kantin/services/item_detail_service.dart';

class ItemDetailProvider with ChangeNotifier {
  List<OrderModel> _itemdetails = [];

  List<OrderModel> get itemdetails => _itemdetails;

  set itemdetails(List<OrderModel> itemdetails) {
    _itemdetails = itemdetails;
    notifyListeners();
  }

  Future<bool> getDetailItem(String token, int id) async {
    try {
      List<OrderModel> itemdetails =
          await ItemDetailService().getDetailItem(token, id);
      _itemdetails = itemdetails;
    } catch (e) {
      print(e);
    }
  }
}
