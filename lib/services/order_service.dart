import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kantin/models/cart_model.dart';

class OrderService {
  String baseUrl = 'http://103.183.75.223/api';

  Future<List<CartModel>> getDetailTransactions(String token) async {
    var url = Uri.parse('$baseUrl/transactions');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(url, headers: headers);
    // print(response.body);

    if (response.statusCode == 200) {
      print('get transaction history');
      var data = jsonDecode(response.body)['data']['data'];

      List<CartModel> carts = [];

      for (var item in data) {
        CartModel cart = CartModel.fromJson(item);
        carts.add(cart);
      }

      return carts;
    } else {
      throw Exception('Gagal Get Transactions!');
    }
  }
}
