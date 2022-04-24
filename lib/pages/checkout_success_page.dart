import 'package:flutter/material.dart';
import 'package:kantin/theme.dart';

class CheckoutSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0.5,
        title: Text(
          'Checkout Success',
          style: TextStyle(
            color: blackColor,
            fontSize: 18,
            fontWeight: bold,
          ),
        ),
        centerTitle: true,
      );
    }

    Widget content() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon_empty_keranjang.png',
              width: 80,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Anda berhasil melakukan pembelian',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
                color: darkBlueColor,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 196,
              height: 44,
              margin: EdgeInsets.only(
                top: defaultMargin,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: Text(
                  'Back to home',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: lightBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
    );
  }
}
