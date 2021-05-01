import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/AppConstants/AppConstant.dart';
import 'package:agrozon/CommonWidgets/ProgressDialog.dart';
import 'package:agrozon/Core/RealtimeDatabase.dart';
import 'package:agrozon/Model/ProductModel.dart';
import 'package:flutter/material.dart';


class ProductDescriptionPage extends StatefulWidget {
  final String productId;

  ProductDescriptionPage({@required this.productId});
  @override
  _ProductDescriptionPageState createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
  List<Product> allproducts = [];
  Product currentProduct;
  int quantity = 1;

  @override
  void initState() {
    getAllProducts();
    super.initState();
  }

  Future<void> getAllProducts() async {
    allproducts = await RealtimeDatabase.getAllProducts();
    setState(() {});
  }

  void getCurrentProduct() async {
    allproducts.forEach((element) {
      if (widget.productId == element.productId) {
        currentProduct = element;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    if (allproducts?.length == 0) {
      return ProgressDialog(text: 'please wait...');
    }
    getCurrentProduct();
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
                    currentProduct.productName,
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
                  currentProduct.imageUrl,
                ),
              ),
              AppConstant.sizer(context: context, h: 0.02, w: 0.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "₹ ",
                    style: TextStyle(
                        color: AppColors.secondaryColor, fontSize: 15),
                  ),
                  Text(currentProduct.price,
                      style: TextStyle(
                          color: AppColors.secondaryColor, fontSize: 20)),
                  AppConstant.sizer(context: context, h: 0.0, w: 0.55),
                  Container(
                    child: InkWell(
                      onTap: () {
                        if (quantity != 30) {
                          setState(() {
                            quantity++;
                          });
                        }
                      },
                      child: Icon(
                        Icons.add,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                  Container(
                    width: 35,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      quantity.toString(),
                      style: TextStyle(
                          color: AppColors.secondaryColor, fontSize: 20),
                    ),
                  ),
                  Container(
                    child: InkWell(
                      splashColor: AppColors.bgWhite,
                      onTap: () {
                        if (quantity != 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                      child: Icon(
                        Icons.remove,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              AppConstant.sizer(context: context, h: 0.02, w: 0.0),
              Container(
                  child: Row(
                children: [
                  Text(
                    currentProduct.rating,
                    style: TextStyle(
                        color: AppColors.secondaryColor, fontSize: 15),
                  ),
                  AppConstant.sizer(context: context, h: 0.0, w: 0.02),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15,
                  )
                ],
              )),
              AppConstant.sizer(context: context, h: 0.02, w: 0.0),
              Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(5),
                  child: InkWell(
                    onTap: () {
                      // setState(() {
                      //   currentProduct.isFavourite = favProvider.addToFav(Product(
                      //       productName: widget.label,
                      //       price: widget.price,
                      //       productDesc: widget.description,
                      //       rating: widget.rating,
                      //       productId: widget.productId,
                      //       imageUrl: widget.imagePath));
                      //   favIcon = Icons.favorite;
                      // });
                      // SnackBar snackBar = SnackBar(
                      //   content: Text(
                      //     isFav
                      //         ? 'Added to Favourites.'
                      //         : 'Already in Favourites.',
                      //     style: TextStyle(
                      //         color: AppColors.bgBlack,
                      //         fontWeight: FontWeight.bold),
                      //   ),
                      //   backgroundColor: AppColors.secondaryColor,
                      //   duration: Duration(seconds: 2),
                      // );
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_outline),
                        Text(
                          "Add To Favourites",
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
                  currentProduct.productDesc,
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
