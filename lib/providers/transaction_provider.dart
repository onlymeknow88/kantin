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

  Future<bool> checkout(
      String token, List<CartModel> carts, int totalPrice) async {
    try {
      if (await TransactionService().checkout(token, carts, totalPrice)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> getTransactions(String token) async {
    try {
      List<TransactionModel> transactions =
          await TransactionService().getTransactions(token);
      _transactions = transactions;
    } catch (e) {
      print(e);
    }
  }
}
