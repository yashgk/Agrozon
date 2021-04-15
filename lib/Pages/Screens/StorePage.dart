import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/AppConstants/AppConstant.dart';
import 'package:flutter/material.dart';
import 'package:agrozon/CommonWidgets/CarouselTile.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  List<int> products = [1, 2, 3, 4, 5, 6];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Stack(children: [
      Container(
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
                    onTap: () {},
                  ),
                  AppConstant.sizer(context: context, h: 0.0, w: 0.05),
                  CarouselTile(
                    label: 'Protection',
                    imagePath: 'assets/images/protect.png',
                    onTap: () {},
                  ),
                  AppConstant.sizer(context: context, h: 0.0, w: 0.05),
                  CarouselTile(
                    label: 'Nutrition',
                    imagePath: 'assets/images/nutrition.png',
                    onTap: () {},
                  ),
                  AppConstant.sizer(context: context, h: 0.0, w: 0.05),
                  CarouselTile(
                    label: 'Hardware',
                    imagePath: 'assets/images/hardware.png',
                    onTap: () {},
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
                children: List.generate(products.length, (index) {
                  return ProductTile(
                      label: 'seed',
                      imagePath: 'assets/images/seed.png',
                      onTap: () {});
                }),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}

class ProductTile extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onTap;
  final double price;

  ProductTile(
      {@required this.label,
      @required this.imagePath,
      @required this.onTap,
      this.price});
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
            Stack(children: [
              InkWell(
                onTap: () {
                  SnackBar snackBar =
                      SnackBar(content: Text('Added to Favourites.'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ),
              Image.asset(
                imagePath,
                height: 200,
                width: 130,
              ),
            ]),
            AppConstant.sizer(context: context, h: 0.01, w: 0.0),
            Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                      color: AppColors.whiteColor, fontWeight: FontWeight.bold),
                ),
                AppConstant.sizer(context: context, h: 0.00, w: 0.175),
                Text(
                  '4.0',
                  style: TextStyle(
                      color: AppColors.whiteColor, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 20,
                  ),
                ),
              ],
            ),
            AppConstant.sizer(context: context, h: 0.01, w: 0.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '₹ 150',
                  style: TextStyle(
                      color: AppColors.whiteColor, fontWeight: FontWeight.bold),
                ),
                AppConstant.sizer(context: context, h: 0.0, w: 0.19),
                InkWell(
                  onTap: () {
                    SnackBar snackBar =
                        SnackBar(content: Text('Added to Kart.'));
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
            )
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
