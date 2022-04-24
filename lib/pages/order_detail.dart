import 'package:flutter/material.dart';
import 'package:kantin/theme.dart';

class OrderDetailPage extends StatefulWidget {
  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  String _value = '';
  Widget build(BuildContext context) {
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
              setState(() {
                if (value == 'print') {
                  print(value);
                }
              });
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
        children: <Widget>[
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
                      'Pending',
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
                      '#1234567890',
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
                      'Rabu, 19 April 2022 / 10:00',
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
                                children: <Widget>[
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
                                          height: 16,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '1 * Nasi Goreng Kambing',
                                              style: subtitleTextStyle,
                                            ),
                                            Text(
                                              'Rp15.000',
                                              style: blackTextStyle.copyWith(
                                                fontSize: 12,
                                                fontWeight: bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '1 * Es Teh',
                                              style: subtitleTextStyle,
                                            ),
                                            Text(
                                              'Rp15.000',
                                              style: blackTextStyle.copyWith(
                                                fontSize: 12,
                                                fontWeight: bold,
                                              ),
                                            ),
                                          ],
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
                                              'Rp30.000',
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
                                  ),
                                ],
                              );
                            });
                      },
                      child: Text(
                        'Detail',
                        style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '2 item',
                    style: subtitleTextStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Rp30.000',
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: bold,
                    ),
                  )
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
                      'Cash',
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
                      'Subtotal (2 item)',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Rp30.000',
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
                      'Diskon',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '-',
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
                      'Rp30.000',
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

// class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   String _value = '';
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: whiteColor,
//       automaticallyImplyLeading: false,
//       elevation: 0.5,
//       leading: IconButton(
//         icon: Icon(
//           Icons.arrow_back,
//           color: blackColor,
//           size: 24,
//         ),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//       title: Text(
//         'Order Detail',
//         style: TextStyle(
//           color: blackColor,
//           fontSize: 18,
//           fontWeight: bold,
//         ),
//       ),
//       iconTheme: IconThemeData(
//         color: blackColor,
//       ),
//       actions: [
//         PopupMenuButton(
//           itemBuilder: (context) {
//             return [
//               PopupMenuItem(
//                 child: Text(
//                   'Print Nota',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: bold,
//                   ),
//                 ),
//                 value: 'print',
//               ),
//             ];
//           },
//           onSelected: (value) {
//             setState(() {
//               // _value = value as String;
//               print(value);
//             });
//           },
//         ),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(58);
// }
