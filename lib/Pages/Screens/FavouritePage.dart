import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/CommonWidgets/ProductTile.dart';
import 'package:agrozon/Core/RealtimeDatabase.dart';
import 'package:agrozon/Model/ProductModel.dart';
import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<Product> favouriteProds = [];
  @override
  void initState() {
    getFav();
    super.initState();
  }

  Future<void> getFav() async {
    favouriteProds = await RealtimeDatabase.getFavList();
    favouriteProds.forEach((element) {
      element.isFavourite = true;
    });
    setState(() {});
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
          children: List.generate(favouriteProds.length, (index) {
            return ProductTile(
              product: favouriteProds[index],
              update: () {
                setState(() {});
              },
            );
          }),
        ),
      ),
    );
  }
}
