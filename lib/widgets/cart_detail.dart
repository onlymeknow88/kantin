import 'package:flutter/material.dart';
import 'package:kantin/models/cart_model.dart';
import 'package:kantin/models/order_model.dart';
import 'package:kantin/models/transaction_model.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/currency_format.dart';
import 'package:provider/provider.dart';

class CartDetailItem extends StatelessWidget {
  final OrderModel itemdetail;
  CartDetailItem(this.itemdetail);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 6,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  '${itemdetail.quantity} * ${itemdetail.product.name}',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              Text(
                'Rp${CurrencyFormat.convertToIdr(itemdetail.PricePajak(), 0)}',
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
