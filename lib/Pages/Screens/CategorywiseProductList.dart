import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/CommonWidgets/ProductTile.dart';
import 'package:agrozon/Core/RealtimeDatabase.dart';
import 'package:agrozon/Model/ProductModel.dart';
import 'package:flutter/material.dart';

class CategorywiseProductList extends StatefulWidget {
  final String title;

  CategorywiseProductList({@required this.title});

  @override
  _CategorywiseProductListState createState() =>
      _CategorywiseProductListState();
}

class _CategorywiseProductListState extends State<CategorywiseProductList> {
  List<Product> product = [];
  Future getAllProducts() async {
    product = await RealtimeDatabase.getProducts(widget.title);
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
    final double itemHeight = (size.height - kToolbarHeight) / 2;
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
          child: Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
              padding: EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: List.generate(product.length, (index) {
                return ProductTile(
                    rating: product[index].rating,
                    price: product[index].price,
                    label: product[index].productName,
                    imagePath: 'assets/images/seed.png',
                    onTap: () {});
              }),
            ),
          ),
        ),
      ),
    );
  }
}
