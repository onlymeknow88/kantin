import 'package:flutter/material.dart';
import 'package:kantin/models/cart_model.dart';
import 'package:kantin/providers/cart_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/currency_format.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final CartModel cart;
  CartItem(this.cart);
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Container(
      margin: EdgeInsets.only(
        top: 6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${cart.quantity.toString()} * ${cart.product.name}',
            style: subtitleTextStyle,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
          ),
          Text(
            CurrencyFormat.convertToIdr(cart.product.price, 0),
            style: blackTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
