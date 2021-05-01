import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/Core/RealtimeDatabase.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Map<dynamic, dynamic> favmap;
  void getFav() async {
    favmap = await RealtimeDatabase.getFavList();
    await RealtimeDatabase.getEachFavProduct(favmap);
  }

  @override
  Widget build(BuildContext context) {
    getFav();

    print(favmap.toString());
    return Container(
      decoration: BoxDecoration(color: AppColors.bgBlack),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ExpansionPanelList(
            children: [],
          )
        ],
      ),
    );
  }
}
