import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData leading;
  final VoidCallback onListItemTap;
  CustomListTile({this.title, this.leading, this.onListItemTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColors.bgWhite,
      leading: Icon(
        leading,
        color: AppColors.secondaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_outlined,
        color: AppColors.secondaryColor,
      ),
      onTap: onListItemTap,
    );
  }
}
