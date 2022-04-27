import 'package:flutter/material.dart';
import '../theme.dart';

class LoadingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: double.infinity,
      margin: EdgeInsets.only(top: 30),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: blueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(
                  whiteColor,
                ),
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              'Loading',
              style: whiteTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
