import 'package:flutter/material.dart';
import 'package:kantin/providers/auth_provider.dart';
import 'package:kantin/providers/cart_provider.dart';
import 'package:kantin/providers/transaction_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/cart_item.dart';
import 'package:kantin/widgets/currency_format.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleCheckout() async {
      setState(() {
        isLoading = true;
      });

      if (await transactionProvider.checkout(
        authProvider.user.token,
        cartProvider.carts,
        cartProvider.totalPrice(),
      )) {
        cartProvider.carts = [];
        Navigator.pushNamedAndRemoveUntil(
            context, '/checkout-success', (route) => false);
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Checkout',
          style: TextStyle(
            color: blackColor,
            fontSize: 18,
            fontWeight: bold,
          ),
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        children: <Widget>[
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pesanan Anda',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/cart');
                      },
                      child: Text(
                        'Edit',
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Column(
                  children: cartProvider.carts
                      .map(
                        (cart) => CartItem(cart),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail Pembayaran',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Metode Pembayaran',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Cash',
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal (${cartProvider.totalItems()} item)',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      CurrencyFormat.convertToIdr(
                          cartProvider.subtotalItem(), 0),
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Fee',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      CurrencyFormat.convertToIdr(3000, 0),
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  thickness: 0.8,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      CurrencyFormat.convertToIdr(cartProvider.totalPrice(), 0),
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Belanja',
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      CurrencyFormat.convertToIdr(cartProvider.totalPrice(), 0),
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 44,
                  width: 150,
                  child: ElevatedButton(
                    child: Text(
                      'Confirm Pesanan',
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        color: whiteColor,
                        fontWeight: bold,
                      ),
                    ),
                    onPressed: handleCheckout,
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      primary: blueColor,
                      shadowColor: Colors.transparent,
                      // minimumSize: Size(210, 50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: header(),
      ),
      body: content(),
    );
  }
}
