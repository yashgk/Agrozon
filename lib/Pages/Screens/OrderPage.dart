import 'package:agrozon/AppConstants/AppColors.dart';

import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
   
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
