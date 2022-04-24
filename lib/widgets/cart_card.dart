import 'package:flutter/material.dart';
import 'package:kantin/theme.dart';

class CartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: defaultMargin,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: lightGrayColor,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage('assets/nasi_goreng1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nasi Goreng Kambing',
                      style: blackTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Rp15.000',
                      style: priceTextStyle,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icon_minus.png',
                    width: 24,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '0',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    'assets/icon_plus.png',
                    width: 24,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
