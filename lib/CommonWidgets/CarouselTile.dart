import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:flutter/material.dart';

class CarouselTile extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onTap;
  CarouselTile(
      {@required this.label, @required this.imagePath, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        height: 120,
        width: 100,
        child: Column(
          children: [
            Image.asset(imagePath),
            Text(
              label,
              style: TextStyle(
                  color: AppColors.whiteColor, fontWeight: FontWeight.bold),
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
                  offset: Offset(0.7, 0.7),
                  spreadRadius: 0.5)
            ]),
      ),
    );
  }
}
