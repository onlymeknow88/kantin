import 'package:flutter/material.dart';
import 'package:kantin/models/category_model.dart';
import 'package:kantin/services/category_service.dart';

class CategoryProvider with ChangeNotifier {
    List<CategoryModel> _categories = [];

  List<CategoryModel> get category => _categories;

  set category(List<CategoryModel> category) {
    _categories = category;
    notifyListeners();
  }

  Future<void> getCategory() async {
    try {
      List<CategoryModel> categories = await CategoryService().getCategories();
      _categories = categories;
    } catch (e) {
      print(e);
    }
  }
}
