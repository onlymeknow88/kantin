import 'package:flutter/material.dart';
import 'package:kantin/pages/checkout_page.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/cart_card.dart';
import 'package:kantin/widgets/custom_page_route.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        children: [
          CartCard(),
          CartCard(),
        ],
      );
    }

    Widget customBottomNav() {
      return Container(
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
                        '2 Item',
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
                              children: <Widget>[
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
                                        height: 16,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '1 * Nasi Goreng Kambing',
                                            style: subtitleTextStyle,
                                          ),
                                          Text(
                                            'Rp15.000',
                                            style: blackTextStyle.copyWith(
                                              fontSize: 12,
                                              fontWeight: bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '1 * Es Teh',
                                            style: subtitleTextStyle,
                                          ),
                                          Text(
                                            'Rp15.000',
                                            style: blackTextStyle.copyWith(
                                              fontSize: 12,
                                              fontWeight: bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Subtotal',
                                            style: subtitleTextStyle.copyWith(
                                              fontWeight: bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            'Rp30.000',
                                            style: blackTextStyle.copyWith(
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
                                ),
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
              height: 44,
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(CustomPageRoute(child: CheckoutPage()));
                },
                style: TextButton.styleFrom(
                  backgroundColor: blueColor,
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
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
                        fontSize: 14,
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
