import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/CommonWidgets/ProductTile.dart';
import 'package:agrozon/Core/RealtimeDatabase.dart';
import 'package:agrozon/Model/ProductModel.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<Product> allProducts = [];
  List<dynamic> favouriteProducts = [];
  Map<dynamic, dynamic> favouriteProduct;
  List<Product> finalFavs = [];
  bool allProdLoaded = false;

  void getFavList() async {
    setState(() {});
    favouriteProducts.clear();
    favouriteProduct = await RealtimeDatabase.getFavList();
    print(favouriteProduct);
    favouriteProducts = favouriteProduct.keys.toList();
    print(favouriteProducts);
    await getFavProducts();
    setState(() {});
  }

  Future getFavProducts() async {
    finalFavs.clear();
    DatabaseReference dbref;

    Map<dynamic, dynamic> prodcat;
    dbref = FirebaseDatabase.instance.reference().child('products');

    await dbref.once().then((DataSnapshot snapshot) {
      //int length = (snapshot.value as List).length;
      if (snapshot.value != null) {
        prodcat = snapshot.value as Map;
        prodcat.values.forEach((element) async {
          List<Product> temp = [];
          temp = await RealtimeDatabase.getEachProductData(element as Map);
          allProducts.addAll(temp);
          print(allProducts.length.toString() + " This is all products length");
          if (allProducts.length == 12) {
            setState(() {
              allProdLoaded = true;
            });
          }
          setState(() {});
        });
      }
    });
    if (allProdLoaded) {
      print(allProducts.length.toString() + " all products length");
      setFavProd();
    }

    setState(() {});
  }

  void setFavProd() {
    for (int i = 0; i < favouriteProducts.length; i++) {
      allProducts.forEach((element) {
        if (element.productId == favouriteProducts[i].toString()) {
          print(element.productId);
          finalFavs.add(element);
        }
      });
    }
    print(finalFavs.length.toString() + "asdfaskdjfkasdjfkds");
    setState(() {});
  }

  @override
  void initState() {
    getFavList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 45) / 2;
    final double itemWidth = size.width / 2;

    return Container(
      padding: EdgeInsets.all(5),
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        color: AppColors.bgBlack,
      ),
      child: Container(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
          padding: EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List.generate(finalFavs.length, (index) {
            return ProductTile(
              rating: finalFavs[index].rating,
              description: finalFavs[index].productDesc,
              price: finalFavs[index].price,
              label: finalFavs[index].productName,
              productId: finalFavs[index].productId,
              imagePath: finalFavs[index].imageUrl,
              isFav: finalFavs[index].isFavourite,
            );
          }),
        ),
      ),
    );
  }
}
