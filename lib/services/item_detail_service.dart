import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kantin/models/order_model.dart';
import 'package:kantin/models/product_model.dart';
import 'package:kantin/models/transaction_model.dart';

class ItemDetailService {
  String baseUrl = 'http://103.183.75.223/api';

  Future<List<OrderModel>> getDetailItem(String token, int id) async {
    var url = Uri.parse('$baseUrl/transactions');
    url = url.replace(queryParameters: {'id': id.toString()});

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      print('ini detail item');
      var data = jsonDecode(response.body);

      List<OrderModel> itemdetails = [];
      data['data']['items'].forEach((item) {
        itemdetails.add(OrderModel(
          id: item['id'],
          product: ProductModel.fromJson(item['product']),
          quantity: item['quantity'],
          transactionsId: item['transactions_id'],
        ));
      });

      return itemdetails;
    } else {
      throw Exception('Gagal Get Item Detail!');
    }
  }
}
