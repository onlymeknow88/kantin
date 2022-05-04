import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kantin/models/transaction_model.dart';
import 'package:kantin/pages/home/main_page.dart';
import 'package:kantin/providers/auth_provider.dart';
import 'package:kantin/providers/page_provider.dart';
import 'package:kantin/providers/transaction_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/cart_detail.dart';
import 'package:kantin/widgets/currency_format.dart';
import 'package:kantin/widgets/custom_page_route.dart';
import 'package:kantin/widgets/nota_card.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class OrderDetailPage extends StatefulWidget {
  final TransactionModel transaction;
  OrderDetailPage(this.transaction);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    DateTime date = widget.transaction.createdAt;
    String dateString =
        DateFormat('EEEE, d MMM yyyy HH:mm:ss', 'id_ID').format(date);

    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);

    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    transactionProvider.getDetailItem(
        Provider.of<AuthProvider>(context, listen: false).user.token,
        widget.transaction.id);

    PageProvider pageProvider = Provider.of<PageProvider>(context);

    cancelOrder() async {
      if (await transactionProvider.cancelOrder(
          authProvider.user.token, widget.transaction.id)) {
        await transactionProvider.getTransactions(authProvider.user.token);
        Navigator.of(context).pushAndRemoveUntil(
          CustomPageRoute(
            child: MainPage(),
          ),
          (route) => false,
        );
        pageProvider.changePage(1);
      }
    }

    Future<bool> showDialogCancel() {
      return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Text('Apakah anda yakin ingin membatalkan pesanan?'),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Tidak',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Ya',
                  style: primaryTextStyle.copyWith(
                    fontWeight: bold,
                  ),
                ),
                onPressed: () {
                  cancelOrder();
                },
              ),
            ],
          );
        },
      );
    }

    Widget headerNota() {
      return AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: blackColor,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        title: Text(
          'Nota',
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

    Future<bool> showModal() {
      return showModalBottomSheet(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        children: transactionProvider.itemdetails
                            .map(
                              (itemdetail) => CartDetailItem(itemdetail),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            );
          });
    }

    Future<bool> notaDetail() {
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
          return SafeArea(
            child: Scaffold(
              backgroundColor: whiteColor,
              appBar: headerNota(),
              body: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(
                    top: 36,
                    left: defaultMargin,
                    right: defaultMargin,
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Kantin Online',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Center(
                        child: Text(
                          'Alamat: Jl. Milenium Satu Arah No.01 RT.01',
                          style: blackTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Kalimantan Timunr, Balikpapan 76123',
                          style: blackTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Text(
                          '${authProvider.user.name} : ${dateString}',
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        child: Center(
                          child: Text(
                              '=============================================='),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 200,
                        child: SfBarcodeGenerator(
                          value: widget.transaction.id.toString(),
                          symbology: QRCode(),
                          showValue: false,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Text(
                          'ORDER ID: ${widget.transaction.id}',
                          style: blackTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Produk',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: bold,
                              )),
                          Text('Harga',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: bold,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: transactionProvider.itemdetails
                            .map(
                              (itemdetail) => NotaCard(itemdetail),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        child: Center(
                          child: Text(
                              '============================================'),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'SubTotal:',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: bold,
                              ),
                            ),
                            Text(
                              CurrencyFormat.convertToIdr(
                                  widget.transaction.subTotalItem, 0),
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Harga + PPN (20%):',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: bold,
                              ),
                            ),
                            Text(
                              CurrencyFormat.convertToIdr(
                                  widget.transaction.totalPrice, 0),
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

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
          'Order Detail',
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
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text(
                    'Nota',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: bold,
                    ),
                  ),
                  value: 'print',
                ),
              ];
            },
            onSelected: (value) {
              notaDetail();
            },
          ),
        ],
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    Text(
                      widget.transaction.status,
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order ID',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                      ),
                    ),
                    Text(
                      '#${widget.transaction.id}',
                      // '#1',
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nama Pemesan',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                      ),
                    ),
                    Text(
                      authProvider.user.name,
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tanggal',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                      ),
                    ),
                    Text(
                      dateString,
                      // 'Rabu, 19 April 2022 / 10:00',
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          SizedBox(
            height: defaultMargin,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pesanan Anda',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  // Container(
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       setState(() {
                  //         showModal();
                  //       });
                  //     },
                  //     child: Text(
                  //       'Detail',
                  //       style: primaryTextStyle.copyWith(
                  //         fontSize: 14,
                  //         fontWeight: bold,
                  //         decoration: TextDecoration.underline,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showModal();
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            '${widget.transaction.items.length} item${widget.transaction.items.length > 1 ? 's' : ''}',
                            style: primaryTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Text(
                          CurrencyFormat.convertToIdr(
                              widget.transaction.subTotalItem, 0),
                          style: primaryTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: defaultMargin,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail Pembayaran',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Metode Pembayaran',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      widget.transaction.payment,
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal (${widget.transaction.items.length} item${widget.transaction.items.length > 1 ? 's' : ''})',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      CurrencyFormat.convertToIdr(
                          widget.transaction.subTotalItem, 0),
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 0.8,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Harga + PPN (20%)',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      CurrencyFormat.convertToIdr(
                          widget.transaction.totalPrice, 0),
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 40,
            margin: EdgeInsets.only(
              top: defaultMargin,
            ),
            padding: EdgeInsets.only(
              right: 200,
            ),
            child: TextButton(
              onPressed: showDialogCancel,
              child: Text(
                'Batalkan Pesanan',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: bold,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: lightBlueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                // padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: header(),
      ),
      body: content(),
      // bottomNavigationBar: customBottomNav(),
    );
  }
}

_displayDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
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
      return SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Hai This Is Full Screen Dialog',
                  style: TextStyle(color: Colors.red, fontSize: 20.0),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "DISMISS",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
