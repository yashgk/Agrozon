import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/Core/RealtimeDatabase.dart';
import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    RealtimeDatabase.getAllProducts();
    return Container(
      decoration: BoxDecoration(color: AppColors.bgBlack),
    );
  }
}
