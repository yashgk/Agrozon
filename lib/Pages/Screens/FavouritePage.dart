import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/CommonWidgets/ProductTile.dart';
import 'package:agrozon/Providers/FavouriteProductProvider.dart';
import 'package:agrozon/Providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  FavouriteProductProvider favProvider;
  UserProvider userProvider;
  @override
  Widget build(BuildContext context) {
    favProvider = Provider.of<FavouriteProductProvider>(context);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 45) / 2;
    final double itemWidth = size.width / 2;
    if (favProvider.favouriteProducts == []) {
      return Container(
        child: Center(
          child: Text(""),
        ),
      );
    } else {
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
            children:
                List.generate(favProvider.favouriteProducts.length, (index) {
              return ProductTile(
                rating: favProvider.favouriteProducts[index].rating,
                description: favProvider.favouriteProducts[index].productDesc,
                price: favProvider.favouriteProducts[index].price,
                label: favProvider.favouriteProducts[index].productName,
                productId: favProvider.favouriteProducts[index].productId,
                imagePath: favProvider.favouriteProducts[index].imageUrl,
              );
            }),
          ),
        ),
      );
    }
  }
}
