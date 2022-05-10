import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kantin/providers/auth_provider.dart';
import 'package:kantin/providers/transaction_provider.dart';
import 'package:kantin/theme.dart';
import 'package:provider/provider.dart';

class HistoryOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    transactionProvider.getHistoryOrder(authProvider.user.token);

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
          'History Order',
          style: TextStyle(
            color: blackColor,
            fontSize: 18,
            fontWeight: bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: blackColor,
        ),
      );
    }

    Widget content() {
      return Container(
        padding: EdgeInsets.all(defaultMargin),
        child: ListView.builder(
          itemCount: transactionProvider.histories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                transactionProvider.histories[index].status,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                DateFormat('EEEE, d MMM yyyy HH:mm:ss', 'id_ID')
                    .format(transactionProvider.histories[index].createdAt),
                style: TextStyle(fontSize: 12),
              ),
              trailing: Text(
                'Rp. ${transactionProvider.histories[index].totalPrice}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => OrderListPage(
                //       transaction: transactionProvider.histories[index],
                //     ),
                //   ),
                // );
              },
            );
          },
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
