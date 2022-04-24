import 'package:flutter/material.dart';
import 'package:kantin/pages/home/akun_page.dart';
import 'package:kantin/pages/home/chat_page.dart';
import 'package:kantin/pages/home/home_page.dart';
import 'package:kantin/pages/home/order_list_page.dart';
import 'package:kantin/theme.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Widget customNavBar() {
    //   return BottomNavigationBar(
    //     type: BottomNavigationBarType.fixed,
    //     currentIndex: currentIndex,
    //     onTap: (value) {
    //       // print(value);
    //       setState(() {
    //         currentIndex = value;
    //       });
    //     },
    //     backgroundColor: redColor,
    //     selectedItemColor: blackColor,
    //     unselectedItemColor: greyColor,
    //     items: [
    //       BottomNavigationBarItem(
    //         icon: ImageIcon(
    //           AssetImage(
    //             'assets/icon_home.png',
    //           ),
    //           size: 24,
    //           color: currentIndex == 0 ? blackColor : greyColor,
    //         ),
    //         label: 'Home',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: ImageIcon(
    //           AssetImage('assets/icon_chat.png'),
    //           size: 24,
    //           color: currentIndex == 1 ? blackColor : greyColor,
    //         ),
    //         label: 'Chat',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: ImageIcon(
    //           AssetImage('assets/icon_order.png'),
    //           size: 24,
    //           color: currentIndex == 2 ? blackColor : greyColor,
    //         ),
    //         label: 'Order',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: ImageIcon(
    //           AssetImage('assets/icon_user.png'),
    //           size: 24,
    //           color: currentIndex == 3 ? blackColor : greyColor,
    //         ),
    //         label: 'Akun',
    //       ),
    //     ],
    //   );
    // }

    Widget body() {
      switch (currentIndex) {
        case 0:
          return HomePage();
          break;
        case 1:
          return ChatPage();
          break;
        case 2:
          return OrderListPage();
          break;
        case 3:
          return AkunPage();
          break;

        default:
          return HomePage();
      }
    }

    Widget buildNavBarItem(IconData icon, text, int index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            currentIndex = index;
          });
        },
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(
            color: whiteColor,
          ),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 9)),
              Icon(icon, color: index == currentIndex ? blackColor : greyColor),
              Text(text,
                  style: TextStyle(
                      color: index == currentIndex ? blackColor : greyColor)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: Row(children: [
        buildNavBarItem(Icons.home, 'Home', 0),
        buildNavBarItem(Icons.textsms, 'Chat', 1),
        buildNavBarItem(Icons.format_list_bulleted, 'Orders', 2),
        buildNavBarItem(Icons.person, 'Akun', 3),
      ]),
      body: body(),
    );
  }
}
