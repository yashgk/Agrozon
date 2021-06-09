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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RealtimeDatabase.getFavList();
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
            children: []
            // List.generate(finalFavs.length, (index) {
            //   return ProductTile(
            //     rating: finalFavs[index].rating,
            //     description: finalFavs[index].productDesc,
            //     price: finalFavs[index].price,
            //     label: finalFavs[index].productName,
            //     productId: finalFavs[index].productId,
            //     imagePath: finalFavs[index].imageUrl,
            //     isFav: finalFavs[index].isFavourite,
            //   );
            // }),
            ),
      ),
    );
  }
}
