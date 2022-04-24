import 'package:flutter/material.dart';
import 'package:kantin/theme.dart';

class ProdukCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: lightGrayColor,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 106,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
              image: DecorationImage(
                image: AssetImage('assets/nasi_goreng.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              'Nasi Goreng Kambing',
              style: blackTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Rp15.000',
                    style: priceTextStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 30,
                  child: ElevatedButton(
                    child: Text(
                      'Add',
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                        color: whiteColor,
                      ),
                    ),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      primary: blueColor,
                      shadowColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
