import 'package:flutter/material.dart';
import 'package:kantin/models/category_model.dart';
import 'package:kantin/providers/product_provider.dart';
import 'package:kantin/theme.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  CategoryItem(this.category);

  @override
  Widget build(BuildContext context) {
    selectCategory() async {
      await Provider.of<ProductProvider>(context, listen: false)
          .getProductsByCategory(category.name);
      Navigator.of(context)
          .pushNamed('/category-feed', arguments: category.name);
    }

    return InkWell(
      onTap: (category.name == 'All' ? null : () => selectCategory()),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        margin: EdgeInsets.only(
          right: 16,
          left: (category.id == 1) ? 16 : 0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: (category.name == 'All' ? blueColor : lightGrayColor),
        ),
        child: Text(
          category.name,
          style: (category.name == 'All' ? whiteTextStyle : blackTextStyle)
              .copyWith(
            fontSize: 14,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
