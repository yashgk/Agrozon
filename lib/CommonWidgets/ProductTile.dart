import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/AppConstants/AppConstant.dart';
import 'package:agrozon/Core/RealtimeDatabase.dart';
import 'package:agrozon/Model/ProductModel.dart';
import 'package:agrozon/Pages/Screens/ProductDescriptionPage.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatefulWidget {
  final Product product;
  final Function update;
  ProductTile({@required this.product, @required this.update});

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  SnackBar snackBar;
  String snackBarText = "";
  bool isFav;

  @override
  Widget build(BuildContext context) {
    isFav = widget.product.isFavourite ?? false;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDescriptionPage(
              product: widget.product,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        height: 200,
        // width: 100,
        child: Column(
          children: [
            Image.network(
              widget.product.imageUrl,
              height: 180,
              width: 130,
            ),
            AppConstant.sizer(context: context, h: 0.01, w: 0.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      widget.product.productName,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            AppConstant.sizer(context: context, h: 0.01, w: 0.0),
            Row(
              children: [
                SizedBox(
                  width: 90,
                  child: Text(
                    widget.product.price,
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  widget.product.rating,
                  style: TextStyle(
                      color: AppColors.whiteColor, fontWeight: FontWeight.bold),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 18,
                  ),
                ),
              ],
            ),
            AppConstant.sizer(context: context, h: 0.01, w: 0.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    if (isFav) {
                      isFav = widget.product.isFavourite =
                          await RealtimeDatabase.removeFavfromdb(
                              productName: widget.product.productName);
                      snackBarText = "Removed from Favourites";
                    } else {
                      isFav = widget.product.isFavourite =
                          await RealtimeDatabase.addFavtodb(
                              product: widget.product);
                      snackBarText = "Added to Favourites";
                    }
                    setState(() {});
                    snackBar = SnackBar(
                      content: Text(
                        snackBarText,
                        style: TextStyle(
                            color: AppColors.bgBlack,
                            fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: AppColors.secondaryColor,
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    widget.update();
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_outline,
                      color: AppColors.bgBlack,
                    ),
                  ),
                ),
                AppConstant.sizer(context: context, h: 0.0, w: 0.02),
                InkWell(
                  onTap: () async {
                    await RealtimeDatabase.addToKart(widget.product.productId);
                    SnackBar snackBar = SnackBar(
                      content: Text(
                        'Added to Kart.',
                        style: TextStyle(
                            color: AppColors.bgBlack,
                            fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: AppColors.secondaryColor,
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add_shopping_cart,
                      color: AppColors.bgBlack,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.bgWhite,
            boxShadow: [
              BoxShadow(
                  color: AppColors.secondaryColor,
                  blurRadius: 1,
                  offset: Offset(0.9, 0.9),
                  spreadRadius: 0.1)
            ]),
      ),
    );
  }
}
