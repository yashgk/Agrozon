import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/AppConstants/AppConstant.dart';
import 'package:agrozon/Model/ProductModel.dart';
import 'package:agrozon/Pages/Screens/ProductDescriptionPage.dart';
import 'package:agrozon/Providers/FavouriteProductProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatefulWidget {
  final String label;
  final String imagePath;
  final String price;
  final String rating;
  final String description;
  final String productId;

  ProductTile({
    @required this.label,
    @required this.imagePath,
    @required this.price,
    @required this.rating,
    @required this.description,
    @required this.productId,
  });

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  FavouriteProductProvider favProvider;
  IconData favIcon = Icons.favorite_border_outlined;
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    favProvider = Provider.of<FavouriteProductProvider>(context);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDescriptionPage(productId: widget.productId),
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
              widget.imagePath,
              height: 180,
              width: 130,
            ),
            AppConstant.sizer(context: context, h: 0.01, w: 0.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      widget.label,
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
                    widget.price,
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  widget.rating,
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
                  onTap: () {
                    setState(() {
                      isFav = favProvider.addToFav(Product(
                          productName: widget.label,
                          price: widget.price,
                          productDesc: widget.description,
                          rating: widget.rating,
                          productId: widget.productId,
                          imageUrl: widget.imagePath));
                      favIcon = Icons.favorite;
                    });
                    SnackBar snackBar = SnackBar(
                      content: Text(
                        isFav
                            ? 'Added to Favourites.'
                            : 'Already in Favourites.',
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
                      favIcon,
                      color: AppColors.bgBlack,
                    ),
                  ),
                ),
                AppConstant.sizer(context: context, h: 0.0, w: 0.02),
                InkWell(
                  onTap: () {
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
