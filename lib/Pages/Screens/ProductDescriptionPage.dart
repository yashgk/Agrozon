import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/AppConstants/AppConstant.dart';
import 'package:agrozon/Core/RealtimeDatabase.dart';
import 'package:agrozon/Model/ProductModel.dart';
import 'package:flutter/material.dart';

class ProductDescriptionPage extends StatefulWidget {
  final Product product;

  ProductDescriptionPage({@required this.product});
  @override
  _ProductDescriptionPageState createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
  SnackBar snackBar;
  String snackBarText = "";
  bool isFav;

  @override
  Widget build(BuildContext context) {
    isFav = widget.product.isFavourite;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(color: AppColors.bgBlack),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.product.productName,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor),
                  ),
                ],
              ),
              AppConstant.sizer(context: context, h: 0.02, w: 0.0),
              Container(
                child: Image.network(
                  widget.product.imageUrl,
                ),
              ),
              AppConstant.sizer(context: context, h: 0.02, w: 0.0),
              Row(
                children: [
                  Text(
                    "₹ ",
                    style: TextStyle(
                        color: AppColors.secondaryColor, fontSize: 15),
                  ),
                  Text(widget.product.price,
                      style: TextStyle(
                          color: AppColors.secondaryColor, fontSize: 20)),
                  AppConstant.sizer(context: context, h: 0.0, w: 0.7),
                  Text(
                    widget.product.rating,
                    style: TextStyle(
                        color: AppColors.secondaryColor, fontSize: 20),
                  ),
                  AppConstant.sizer(context: context, h: 0.0, w: 0.02),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15,
                  )
                ],
              ),
              AppConstant.sizer(context: context, h: 0.02, w: 0.0),
              Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(5),
                  child: InkWell(
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
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isFav
                            ? Icon(Icons.favorite_rounded)
                            : Icon(Icons.favorite_outline),
                        Text(
                          isFav
                              ? "Remove from Favourites"
                              : "Add To Favourites",
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  )),
              AppConstant.sizer(context: context, h: 0.02, w: 0.0),
              Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(5),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart),
                        Text(
                          "Add To Cart",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  )),
              AppConstant.sizer(context: context, h: 0.02, w: 0.0),
              Row(
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              AppConstant.sizer(context: context, h: 0.01, w: 0.0),
              Container(
                  child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.product.productDesc,
                  textAlign: TextAlign.left,
                  style:
                      TextStyle(color: AppColors.secondaryColor, fontSize: 20),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
