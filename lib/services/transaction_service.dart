import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kantin/models/cart_model.dart';
import 'package:kantin/models/product_model.dart';
import 'package:kantin/models/transaction_model.dart';

class TransactionService {
  String baseUrl = 'http://103.183.75.223/api';

  Future<bool> checkout(
      String token, List<CartModel> carts, int totalPrice) async {
    var url = '$baseUrl/checkout';
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
      },
    );

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Melakukan Checkout!');
    }
  }

  Future<List<TransactionModel>> getTransactions(String token) async {
    var url = '$baseUrl/transactions';
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // print('get order list');
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
}
