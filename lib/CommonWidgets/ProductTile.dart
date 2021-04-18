import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/AppConstants/AppConstant.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onTap;
  final String price;
  final String rating;

  ProductTile(
      {@required this.label,
      @required this.imagePath,
      @required this.onTap,
      @required this.price,
      @required this.rating});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        SnackBar snackBar = SnackBar(content: Text('Item Displayed'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        height: 200,
        // width: 100,
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 180,
              width: 130,
            ),
            AppConstant.sizer(context: context, h: 0.01, w: 0.0),
            Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                      color: AppColors.whiteColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            AppConstant.sizer(context: context, h: 0.01, w: 0.0),
            Row(
              children: [
                SizedBox(
                  width: 90,
                  child: Text(
                    price,
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  rating,
                  style: TextStyle(
                      color: AppColors.whiteColor, fontWeight: FontWeight.bold),
                ),
                Expanded(
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
                    SnackBar snackBar = SnackBar(
                      content: Text(
                        'Added to Favourites.',
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
                      Icons.favorite,
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
