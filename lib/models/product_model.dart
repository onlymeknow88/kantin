import 'package:kantin/models/category_model.dart';
import 'package:kantin/models/gallery_model.dart';

class ProductModel {
  int id;
  String name;
  int price;
  String description;
  String tags;
  CategoryModel category;
  DateTime createdAt;
  DateTime updatedAt;
  List<GalleryModel> galleries;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.description,
    this.tags,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.galleries,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = int.parse(json['price'].toString());
    description = json['description'];
    tags = json['tags'];

    if (json['category'] == null) {
      category = null;
    } else {
      category = CategoryModel.fromJson(json['category']);
    }
    if (json['galleries'] == null) {
      galleries = null;
    } else {
      galleries = json['galleries']
          .map<GalleryModel>((item) => GalleryModel.fromJson(item))
          .toList();
    }

    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'tags': tags,
      'category': category.toJson(),
      'galleries': galleries.map((gallery) => gallery.toJson()).toList(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}
