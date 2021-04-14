import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/AppConstants/AppConstant.dart';
import 'package:agrozon/AppConstants/AppString.dart';
import 'package:flutter/material.dart';
import 'package:agrozon/CommonWidgets/CarouselTile.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: AppColors.bgBlack),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Catagory',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              AppConstant.sizer(context: context, h: 0.01, w: 0.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CarouselTile(
                      label: 'Seed',
                      imagePath: 'assets/images/seed.png',
                      onTap: () {},
                    ),
                    CarouselTile(
                      label: 'Seed',
                      imagePath: 'assets/images/seed.png',
                      onTap: () {},
                    ),
                    CarouselTile(
                      label: 'Seed',
                      imagePath: 'assets/images/seed.png',
                      onTap: () {},
                    ),
                    CarouselTile(
                      label: 'Seed',
                      imagePath: 'assets/images/seed.png',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
