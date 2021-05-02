import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/AppConstants/AppConstant.dart';
import 'package:agrozon/Core/RealtimeDatabase.dart';
import 'package:agrozon/Model/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:agrozon/CommonWidgets/CarouselTile.dart';
import 'package:agrozon/CommonWidgets/ProductTile.dart';
import 'package:agrozon/Pages/Screens/CategorywiseProductList.dart';

class StorePage extends StatefulWidget {
  final List<Product> allproducts;
  StorePage({
    @required this.allproducts,
  });
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: AppColors.bgBlack),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppConstant.sizer(context: context, h: 0.0, w: 0.03),
              Text(
                'Category',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          AppConstant.sizer(context: context, h: 0.01, w: 0.0),
          SingleChildScrollView(
            padding: EdgeInsets.all(10),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CarouselTile(
                  label: 'Seed',
                  imagePath: 'assets/images/seed.png',
                  onTap: () async {
                    List<Product> product = [];
                    product =
                        await RealtimeDatabase.getCategoryProducts('seeds');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategorywiseProductList(
                          title: "seeds",
                          product: product,
                        ),
                      ),
                    );
                  },
                ),
                AppConstant.sizer(context: context, h: 0.0, w: 0.05),
                CarouselTile(
                  label: 'Protection',
                  imagePath: 'assets/images/protect.png',
                  onTap: () async {
                    List<Product> product = [];
                    product =
                        await RealtimeDatabase.getCategoryProducts('pestiside');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategorywiseProductList(
                                  title: "pestiside",
                                  product: product,
                                )));
                  },
                ),
                AppConstant.sizer(context: context, h: 0.0, w: 0.05),
                CarouselTile(
                  label: 'Nutrition',
                  imagePath: 'assets/images/nutrition.png',
                  onTap: () async {
                    List<Product> product = [];
                    product = await RealtimeDatabase.getCategoryProducts(
                        'fertilizer');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategorywiseProductList(
                          title: "fertilizer",
                          product: product,
                        ),
                      ),
                    );
                  },
                ),
                AppConstant.sizer(context: context, h: 0.0, w: 0.05),
                CarouselTile(
                  label: 'Hardware',
                  imagePath: 'assets/images/hardware.png',
                  onTap: () async {
                    List<Product> product = [];
                    product =
                        await RealtimeDatabase.getCategoryProducts('hardware');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategorywiseProductList(
                                  title: "hardware",
                                  product: product,
                                )));
                  },
                ),
              ],
            ),
          ),
          AppConstant.sizer(context: context, h: 0.01, w: 0.0),
          Row(
            children: [
              AppConstant.sizer(context: context, h: 0.0, w: 0.03),
              Text(
                'All Products',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          AppConstant.sizer(context: context, h: 0.01, w: 0.0),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
              padding: EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: List.generate(widget.allproducts.length, (index) {
                return ProductTile(
                  rating: widget.allproducts[index].rating,
                  price: widget.allproducts[index].price,
                  productId: widget.allproducts[index].productId,
                  description: widget.allproducts[index].productDesc,
                  label: widget.allproducts[index].productName,
                  imagePath: widget.allproducts[index].imageUrl,
                  isFav: widget.allproducts[index].isFavourite,
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
