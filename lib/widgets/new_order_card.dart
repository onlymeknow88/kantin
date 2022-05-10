import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kantin/models/transaction_model.dart';
import 'package:kantin/pages/admin/detail_new_order.dart';
import 'package:kantin/providers/auth_provider.dart';
import 'package:kantin/providers/transaction_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/custom_page_route.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewOrderCard extends StatefulWidget {
  final TransactionModel transaction;
  NewOrderCard(this.transaction);

  @override
  State<NewOrderCard> createState() => _NewOrderCardState();
}

class _NewOrderCardState extends State<NewOrderCard> {
  TransactionProvider transactionProvider = TransactionProvider();


  Future showDetail() {
    return showGeneralDialog(
        context: context,
        barrierColor: whiteColor.withOpacity(0.1),
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 300),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return SafeArea(child: NewOrderDetail(widget.transaction));
        });
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = widget.transaction.createdAt;
    String dateString =
        DateFormat('EEEE, d MMM yyyy HH:mm:ss', 'id_ID').format(date);

    return GestureDetector(
      onTap: () {
        setState(() {});
        showDetail();
      },
      child: Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: lightGrayColor,
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order ID: #${widget.transaction.id}',
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  dateString,
                  style: subtitleTextStyle,
                ),
              ],
            ),
            Container(
              height: 20,
              padding: EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 14,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: lightBlueColor,
              ),
              child: Text(
                widget.transaction.status,
                style: primaryTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
