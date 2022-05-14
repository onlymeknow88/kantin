import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kantin/providers/auth_provider.dart';
import 'package:kantin/providers/transaction_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/currency_format.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryOrderPage extends StatefulWidget {
  @override
  State<HistoryOrderPage> createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends State<HistoryOrderPage> {
  void initState() {
    // TODO: implement initState
    getHistories();
    super.initState();
  }

  Future<void> getHistories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    await Provider.of<TransactionProvider>(context, listen: false)
        .getHistoryOrder(token);
    setState(() {});
  }

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
          // "${selectedDate.toLocal()}".split(' ')[0],
          style: TextStyle(
            color: blackColor,
            fontSize: 18,
            fontWeight: bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: blackColor,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.date_range,
              color: blackColor,
              size: 24,
            ),
            onPressed: () => {
            },
          ),
        ],
      );
    }

    Widget content() {
      return RefreshIndicator(
        onRefresh: getHistories,
        child: Container(
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
                  CurrencyFormat.convertToIdr(
                      transactionProvider.histories[index].totalPrice, 0),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {},
              );
            },
          ),
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
