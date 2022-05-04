import 'package:flutter/material.dart';
import 'package:kantin/models/cart_model.dart';
import 'package:kantin/models/transaction_model.dart';
import 'package:kantin/services/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  set transactions(List<TransactionModel> transactions) {
    _transactions = transactions;
    notifyListeners();
  }

  Future<bool> checkout(String token, List<CartModel> carts, double totalPrice,
      double subTotaItem) async {
    try {
      if (await TransactionService()
          .checkout(token, carts, totalPrice, subTotaItem)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> cancelOrder(String token, int id) async {
    try {
      if (await TransactionService().cancelOrder(token,id)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getTransactions(String token) async {
    try {
      List<TransactionModel> transactions =
          await TransactionService().getTransactions(token);
      _transactions = transactions;
    } catch (e) {
      print(e);
    }
  }

  List<CartModel> _itemdetails = [];

  List<CartModel> get itemdetails => _itemdetails;

  set itemdetails(List<CartModel> itemdetails) {
    _itemdetails = itemdetails;
    notifyListeners();
  }

  Future<bool> getDetailItem(String token, int id) async {
    try {
      List<CartModel> itemdetails =
          await TransactionService().getDetailItem(token, id);
      _itemdetails = itemdetails;
    } catch (e) {
      print(e);
    }
  }
}
