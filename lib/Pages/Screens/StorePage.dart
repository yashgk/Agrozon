import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/AppConstants/AppConstant.dart';
import 'package:agrozon/Core/RealtimeDatabase.dart';
import 'package:agrozon/Model/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:agrozon/CommonWidgets/CarouselTile.dart';
import 'package:agrozon/CommonWidgets/ProductTile.dart';
import 'package:agrozon/Pages/Screens/CategorywiseProductList.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  List<Product> allproducts = [];
  Future getAllProducts() async {
    allproducts = await RealtimeDatabase.getAllProducts();
  }

  @override
  void initState() {
    getAllProducts();
    super.initState();
  }

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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategorywiseProductList(
                                  title: "seeds",
                                )));
                  },
                ),
                AppConstant.sizer(context: context, h: 0.0, w: 0.05),
                CarouselTile(
                  label: 'Protection',
                  imagePath: 'assets/images/protect.png',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategorywiseProductList(
                                  title: "pestiside",
                                )));
                  },
                ),
                AppConstant.sizer(context: context, h: 0.0, w: 0.05),
                CarouselTile(
                  label: 'Nutrition',
                  imagePath: 'assets/images/nutrition.png',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategorywiseProductList(
                                  title: "fertilizer",
                                )));
                  },
                ),
                AppConstant.sizer(context: context, h: 0.0, w: 0.05),
                CarouselTile(
                  label: 'Hardware',
                  imagePath: 'assets/images/hardware.png',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategorywiseProductList(
                                  title: "hardware",
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
              AppConstant.sizer(context: context, h: 0.0, w: 0.55),
              InkWell(
                child: Icon(
                  Icons.sort,
                  size: 25,
                  color: AppColors.secondaryColor,
                ),
                onTap: () {},
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
              children: List.generate(allproducts.length, (index) {
                return ProductTile(
                    rating: allproducts[index].rating,
                    price: allproducts[index].price,
                    label: allproducts[index].productName,
                    imagePath: 'assets/images/seed.png',
                    onTap: () {});
              }),
            ),
          )
        ],
      ),
    );
  }
}
