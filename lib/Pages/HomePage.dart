import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:agrozon/Pages/Screens/StorePage.dart';
import 'package:agrozon/Pages/Screens/SettingPage.dart';
import 'package:agrozon/Pages/Screens/ProfilePage.dart';
import 'package:agrozon/Pages/Screens/FavouritePage.dart';
import 'package:agrozon/Pages/Screens/OrderPage.dart';
import 'package:agrozon/CommonWidgets/CustomAppBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List<Widget> screenList = [
    StorePage(),
    SettingPage(),
    ProfilePage(),
    FavouritePage(),
    OrderPage(),
  ];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        child: screenList.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.store_outlined),
            label: 'Store',
            activeIcon: Icon(Icons.store),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shop_outlined),
              label: 'Orders',
              activeIcon: Icon(Icons.shop)),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: 'Favourites',
              activeIcon: Icon(Icons.favorite)),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
              activeIcon: Icon(Icons.settings)),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
              activeIcon: Icon(Icons.person)),
        ],
        currentIndex: selectedIndex,
        backgroundColor: AppColors.bgWhite,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.secondaryColor,
        unselectedItemColor: AppColors.whiteColor,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) => onItemTapped(index),
      ),
    );
  }
}
