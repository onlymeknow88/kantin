import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kantin/models/category_model.dart';

class CategoryService {
  String baseUrl = 'http://103.179.57.17/api';

  Future<List<CategoryModel>> getCategories() async {
    var url = Uri.parse('$baseUrl/categories');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['data'];

      List<CategoryModel> categories = [];

      for (var item in data) {
        CategoryModel category = CategoryModel.fromJson(item);
        categories.add(category);
      }

      return categories;
    } else {
      throw Exception('Gagal Get Categories!');
    }
  }
}
