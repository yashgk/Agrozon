import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:agrozon/Core/RealtimeDatabase.dart';
import 'package:agrozon/Model/ProductModel.dart';

import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Product> allproducts = [];
  List<Product> favouriteProds = [];
  Map<dynamic, dynamic> kartMap = {};
  List<Product> kartProducts = [];
  List<dynamic> qty = [];
  bool deleteItem = false;
  TextStyle textStyle = TextStyle(
      color: AppColors.secondaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 20);

  Future<void> getAllProducts() async {
    allproducts = await RealtimeDatabase.getAllProducts();
    setState(() {});
  }

  Future<void> getFav() async {
    favouriteProds = await RealtimeDatabase.getFavList();
    favouriteProds.forEach((element) {
      element.isFavourite = true;
    });

    setState(() {});
  }

  Future<void> getKartList() async {
    kartMap = await RealtimeDatabase.getKartList();
    setState(() {});
  }

  Future<void> finalize() async {
    await getAllProducts();
    await getKartList();
    qty = kartMap.values.toList();
    kartMap.keys.forEach((kartElement) {
      allproducts.forEach((element) {
        if (element.productId == kartElement) {
          kartProducts.add(element);
        }
      });
    });

    setState(() {});
  }

  @override
  void initState() {
    finalize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: AppColors.bgBlack),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: kartProducts.length,
              itemBuilder: (context, index) {
                return Container(
                    color: AppColors.bgWhite,
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Image.network(
                          kartProducts[index].imageUrl,
                          height: 80,
                          width: 80,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                kartProducts[index].productName,
                                style: textStyle,
                              ),
                              Text(
                                "₹ " + kartProducts[index].price,
                                style: textStyle,
                              ),
                              Text(
                                "Ratings : " + kartProducts[index].rating,
                                style: textStyle,
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: InkWell(
                                onTap: () async {
                                  if (int.parse(qty[index]) != 30) {
                                    await RealtimeDatabase.addToKart(
                                        kartProducts[index].productId);
                                    await getKartList();

                                    setState(() {
                                      qty = kartMap.values.toList();
                                    });
                                  }
                                },
                                child: Icon(
                                  Icons.add,
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                            ),
                            Container(
                              width: 35,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                qty[index].toString() ?? "",
                                style: TextStyle(
                                    color: AppColors.secondaryColor,
                                    fontSize: 20),
                              ),
                            ),
                            Container(
                              child: InkWell(
                                splashColor: AppColors.bgWhite,
                                onTap: () async {
                                  if (int.parse(qty[index]) == 1) {
                                    await RealtimeDatabase.deleteFromKart(
                                        kartProducts[index].productId);
                                    await getKartList();
                                    kartProducts.removeWhere((element) =>
                                        element.productId ==
                                        kartProducts[index].productId);
                                  } else {
                                    await RealtimeDatabase.removeFromKart(
                                        kartProducts[index].productId);
                                  }
                                  await getKartList();
                                  setState(() {
                                    qty = kartMap.values.toList();
                                  });
                                },
                                child: Icon(
                                  int.parse(qty[index]) == 1
                                      ? Icons.delete
                                      : Icons.remove,
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ));
              }),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(primary: AppColors.bgWhite),
                child: Text(
                  "Checkout",
                  style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ))
        ],
      ),
    );
  }
}
