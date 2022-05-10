import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kantin/models/cart_model.dart';
import 'package:kantin/models/product_model.dart';
import 'package:kantin/models/transaction_model.dart';

class TransactionService {
  String baseUrl = 'http://103.183.75.223/api';

  Future<bool> checkout(String token, List<CartModel> carts, double totalPrice,
      double subTotalItem) async {
    var url = Uri.parse('$baseUrl/checkout');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode(
      {
        'items': carts
            .map(
              (cart) => {
                'id': cart.product.id,
                'quantity': cart.quantity,
              },
            )
            .toList(),
        'status': "PENDING",
        'total_price': totalPrice,
        'sub_total_item': subTotalItem,
      },
    );

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Melakukan Checkout!');
    }
  }

  Future<List<TransactionModel>> getTransactions(String token) async {
    var url = Uri.parse('$baseUrl/transactions');
    url = url.replace(queryParameters: {'status': 'PENDING'});
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['data'];

      List<TransactionModel> transactions = [];

      for (var item in data) {
        var transaction = TransactionModel.fromJson(item);
        transactions.add(transaction);
      }

      return transactions;
    } else {
      throw Exception('Gagal Get Transactions!');
    }
  }

  Future<List<TransactionModel>> getTransactionsByStatus(String token) async {
    var url = Uri.parse('$baseUrl/transactions-status');
    url = url.replace(queryParameters: {'status': 'PENDING'});

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      List<TransactionModel> transactionsbystatus = [];

      for (var item in data) {
        var transactionbystatus = TransactionModel.fromJson(item);
        transactionsbystatus.add(transactionbystatus);
      }

      return transactionsbystatus;
    } else {
      throw Exception('Gagal Get Transactions!');
    }
  }

  Future<List<CartModel>> getDetailItem(String token, int id) async {
    var url = Uri.parse('$baseUrl/transactions');
    url = url.replace(queryParameters: {'id': id.toString()});

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      List<CartModel> itemdetails = [];
      data['data']['items'].forEach((item) {
        itemdetails.add(CartModel(
          id: item['id'],
          product: ProductModel.fromJson(item['product']),
          quantity: item['quantity'],
          // transactionsId: item['transactions_id'],
        ));
      });

      return itemdetails;
    } else {
      throw Exception('Gagal Get Item Detail!');
    }
  }

  Future<bool> cancelOrder(String token, int id) async {
    var url = Uri.parse('$baseUrl/cancel-order');
    url = url.replace(queryParameters: {'id': id.toString()});

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode(
      {
        'status': 'CANCELLED',
      },
    );

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Melakukan Cancel Order!');
    }
  }

  Future<List<TransactionModel>> getHistoryOrder(String token) async {
    var url = Uri.parse('$baseUrl/transactions-history');
    url = url.replace(queryParameters: {
      'status_cancel': 'CANCELLED',
      'status_sucess': 'SUCCESS'
    });

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      List<TransactionModel> histories = [];

      for (var item in data['cancel']) {
        var history = TransactionModel.fromJson(item);
        histories.add(history);
      }

      for (var item in data['success']) {
        var history = TransactionModel.fromJson(item);
        histories.add(history);
      }

      return histories;
    } else {
      throw Exception('Gagal Get Transactions!');
    }
  }
}
