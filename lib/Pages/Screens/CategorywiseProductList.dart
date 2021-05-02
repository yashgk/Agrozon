import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/CommonWidgets/ProductTile.dart';
import 'package:agrozon/Model/ProductModel.dart';
import 'package:flutter/material.dart';

class CategorywiseProductList extends StatefulWidget {
  final List<Product> product;
  final String title;
  CategorywiseProductList({@required this.title, @required this.product});

  @override
  _CategorywiseProductListState createState() =>
      _CategorywiseProductListState();
}

class _CategorywiseProductListState extends State<CategorywiseProductList> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 45) / 2;
    final double itemWidth = size.width / 2;
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(color: AppColors.secondaryColor),
          ),
          centerTitle: true,
          backgroundColor: AppColors.bgWhite,
          leading: InkWell(
            child: Icon(Icons.arrow_back_ios, color: AppColors.secondaryColor),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(5),
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: AppColors.bgBlack,
          ),
          child: Container(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
              padding: EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: List.generate(widget.product.length, (index) {
                return ProductTile(
                  rating: widget.product[index].rating,
                  description: widget.product[index].productDesc,
                  productId: widget.product[index].productId,
                  price: widget.product[index].price,
                  label: widget.product[index].productName,
                  imagePath: widget.product[index].imageUrl,
                  isFav: widget.product[index].isFavourite,
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
