import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/CommonWidgets/ProgressDialog.dart';
import 'package:agrozon/Core/RealtimeDatabase.dart';
import 'package:agrozon/Model/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:agrozon/Pages/Screens/StorePage.dart';
import 'package:agrozon/Pages/Screens/AccountPage.dart';
import 'package:agrozon/Pages/Screens/FavouritePage.dart';
import 'package:agrozon/Pages/Screens/OrderPage.dart';
import 'package:agrozon/CommonWidgets/CustomAppBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List<Widget> screenList;
  List<Product> allproducts = [];
  Map<dynamic, dynamic> favouriteProduct;

//to get all product list from database
  Future<void> getAllProducts() async {
    allproducts = await RealtimeDatabase.getAllProducts();
    setState(() {});
  }

// to get user's favourite list from database
  void getFavList() async {
    favouriteProduct = await RealtimeDatabase.getFavList();
  }

// to set isFavourite boolean for perticuler product
  void setFavBool() async {
    allproducts.forEach((element) {
      favouriteProduct.keys.forEach((key) {
        if (element.productId == key.toString()) {
          setState(() {
            element.isFavourite = true;
          });
        }
      });
    });
  }

  void initTabs(List<Product> plist) async {
    setState(() {
      screenList = [
        StorePage(
          allproducts: plist,
        ),
        OrderPage(),
        FavouritePage(allproducts: plist),
        AccountPage(),
      ];
    });
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    getAllProducts();
    getFavList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (allproducts?.length == 0) {
      return ProgressDialog(text: 'please wait...');
    }
    setFavBool();
    initTabs(allproducts);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Orders',
              activeIcon: Icon(Icons.shopping_cart)),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: 'Favourites',
              activeIcon: Icon(Icons.favorite)),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Account',
              activeIcon: Icon(Icons.account_circle)),
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
