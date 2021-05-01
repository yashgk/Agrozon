import 'package:flutter/material.dart';

class Product {
  String productId;
  String productName;
  String productDesc;
  String price;
  String rating;
  bool isFavourite;
  String imageUrl;
  Product(
      {@required this.productId,
      @required this.productName,
      @required this.productDesc,
      @required this.price,
      @required this.rating,
      this.isFavourite = false,
      @required this.imageUrl});
}
