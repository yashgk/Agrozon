import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/CommonWidgets/ProductTile.dart';
import 'package:agrozon/Model/ProductModel.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  final List<Product> allproducts;
  FavouritePage({this.allproducts});
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<Product> favouriteProducts = [];

  void getFavouriteList() {
    widget.allproducts.forEach((element) {
      if (element.isFavourite == true) {
        favouriteProducts.add(element);
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 45) / 2;
    final double itemWidth = size.width / 2;
    getFavouriteList();
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
          children: List.generate(favouriteProducts.length, (index) {
            return ProductTile(
              rating: favouriteProducts[index].rating,
              description: favouriteProducts[index].productDesc,
              price: favouriteProducts[index].price,
              label: favouriteProducts[index].productName,
              productId: favouriteProducts[index].productId,
              imagePath: favouriteProducts[index].imageUrl,
              isFav: favouriteProducts[index].isFavourite,
            );
          }),
        ),
      ),
    );
  }
}
