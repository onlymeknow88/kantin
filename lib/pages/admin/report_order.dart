import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kantin/providers/auth_provider.dart';
import 'package:kantin/providers/transaction_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/currency_format.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportOrderPage extends StatefulWidget {
  @override
  State<ReportOrderPage> createState() => _ReportOrderPageState();
}

class _ReportOrderPageState extends State<ReportOrderPage> {
  DateTime selectedDate = DateTime.now();
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReport();
  }

  Future<void> getReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    await Provider.of<TransactionProvider>(context, listen: false)
        .getReportOrderByDate(token, dateinput.text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    transactionProvider.getReportOrderByDate(
        authProvider.user.token, dateinput.text);

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
            dateinput.clear();
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Report Order',
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
            onPressed: () async {
              DateTime pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(
                      2000), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);

                setState(() {
                  dateinput.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
        ],
      );
    }

    Widget content() {
      return RefreshIndicator(
        onRefresh: getReport,
        child: dateinput.text.isEmpty
            ? Container(
                child: Center(
                  child: Text(
                    'Please select date first!',
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            : Container(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: transactionProvider.reporthistoryorder.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          transactionProvider.reporthistoryorder[index].status,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          DateFormat('EEEE, d MMM yyyy HH:mm:ss', 'id_ID')
                              .format(transactionProvider
                                  .reporthistoryorder[index].createdAt),
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: Text(
                          CurrencyFormat.convertToIdr(
                              transactionProvider
                                  .reporthistoryorder[index].totalPrice,
                              0),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ),
      );
    }

    // return Scaffold(
    //   backgroundColor: whiteColor,
    //   appBar: PreferredSize(
    //     preferredSize: Size.fromHeight(50.0),
    //     child: header(),
    //   ),
    //   body: content(),
    // );

    return ListView(
      children: [
        header(),
        content(),
      ],
    );
  }
}
