import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kantin/models/transaction_model.dart';
import 'package:kantin/providers/auth_provider.dart';
import 'package:kantin/providers/item_detail_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/cart_detail.dart';
import 'package:kantin/widgets/currency_format.dart';
import 'package:provider/provider.dart';

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
    String dateString = DateFormat('E, d MMM yyyy HH:mm:ss').format(date);
    ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);

    itemDetailProvider.getDetailItem(
        Provider.of<AuthProvider>(context, listen: false).user.token,
        widget.transaction.id);

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
            // setState(() {
            // });
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
                    'Print Nota',
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
              // print(value);
              // setState(() {
              //   if (value == 'print') {
              //     print(value);
              //   }
              // });
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
                      'Ace On',
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
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
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
                                          height: 6,
                                        ),
                                        Column(
                                          children: itemDetailProvider
                                              .itemdetails
                                              .map(
                                                (itemdetail) =>
                                                    CartDetailItem(itemdetail),
                                              )
                                              .toList(),
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
                                              CurrencyFormat.convertToIdr(
                                                  widget.transaction.totalPrice,
                                                  0),
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
                                  )
                                ],
                              );
                            });
                      },
                      child: Text(
                        'Detail',
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          '${widget.transaction.items.length} item${widget.transaction.items.length > 1 ? 's' : ''}',
                          style: subtitleTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: medium,
                          ),
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
                          widget.transaction.totalPrice, 0),
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
                      'Pajak Bayar',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Rp 3.000',
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
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
                      'Total',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      CurrencyFormat.convertToIdr(
                          widget.transaction.PajakBayar(), 0),
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
            height: 32,
            margin: EdgeInsets.only(
              top: defaultMargin,
            ),
            padding: EdgeInsets.only(
              right: 232,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Text(
                'Cancel Order',
                style: primaryTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: bold,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: lightBlueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
