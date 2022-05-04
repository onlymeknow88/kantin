import 'package:flutter/material.dart';
import 'package:kantin/providers/cart_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/cart_card.dart';
import 'package:kantin/widgets/cart_item.dart';
import 'package:kantin/widgets/currency_format.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
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
          'Orders',
          style: TextStyle(
            color: blackColor,
            fontSize: 18,
            fontWeight: bold,
          ),
        ),
      );
    }

    Widget emptyCart() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon_empty_cart.png',
              width: 80,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Opss! Your Cart is Empty',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
                color: darkBlueColor,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Silahkan pilih produk yang ingin dibeli',
              style: subtitleTextStyle,
            ),
            Container(
              width: 154,
              height: 44,
              margin: EdgeInsets.only(
                top: 20,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                },
                style: TextButton.styleFrom(
                  backgroundColor: blueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Back to Home',
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        children: cartProvider.carts
            .map(
              (cart) => CartCard(cart),
            )
            .toList(),
      );
    }

    Widget customBottomNav() {
      return cartProvider.totalPrice() == 0
          ? Container()
          : Container(
              height: 120,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: defaultMargin,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cart',
                              style: blackTextStyle.copyWith(
                                  fontSize: 14, fontWeight: regular),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              '${cartProvider.totalItems()} Item',
                              style: blackTextStyle.copyWith(
                                  fontSize: 14, fontWeight: bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: defaultMargin,
                        ),
                        child: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Wrap(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: defaultMargin,
                                          horizontal: defaultMargin,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Text(
                                              'Ringkasan Belanja',
                                              style: blackTextStyle.copyWith(
                                                fontSize: 18,
                                                fontWeight: bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Column(
                                              children: cartProvider.carts
                                                  .map(
                                                    (cart) => CartItem(cart),
                                                  )
                                                  .toList(),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Subtotal',
                                                  style: subtitleTextStyle
                                                      .copyWith(
                                                    fontWeight: bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  CurrencyFormat.convertToIdr(
                                                      cartProvider
                                                          .subtotalItem(),
                                                      0),
                                                  style:
                                                      blackTextStyle.copyWith(
                                                    fontSize: 14,
                                                    fontWeight: bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            'Detail',
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(
                      horizontal: defaultMargin,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/checkout');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: blueColor,
                        padding: EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Continue to Checkout',
                            style: whiteTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: whiteColor,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: header(),
      ),
      body: content(),
      bottomNavigationBar: customBottomNav(),
    );
  }
}
