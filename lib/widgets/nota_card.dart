import 'package:flutter/material.dart';
import 'package:kantin/models/cart_model.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/currency_format.dart';

class NotaCard extends StatelessWidget {
  final CartModel itemdetail;
  NotaCard(this.itemdetail);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${itemdetail.quantity.toString()} - ${itemdetail.product.name}',
            style: blackTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
          Text(
            CurrencyFormat.convertToIdr(itemdetail.product.price, 0),
            style: blackTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
