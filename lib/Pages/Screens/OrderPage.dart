import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/Core/RealtimeDatabase.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RealtimeDatabase.getFavList();
    return Container(
      decoration: BoxDecoration(color: AppColors.bgBlack),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ExpansionPanelList(
            children: [
              // ExpansionPanel(headerBuilder: headerBuilder, body: body),
              // ExpansionPanel(headerBuilder: headerBuilder, body: body),
            ],
          )
        ],
      ),
    );
  }
}
