import 'package:agrozon/AppConstants/AppConstant.dart';
import 'package:agrozon/Model/ProductModel.dart';
import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabase {
  static Future<List<Product>> getAllProducts() async {
    DatabaseReference dbref;
    final List<Product> allProducts = [];
    Map<dynamic, dynamic> prodcat;
    dbref = FirebaseDatabase.instance.reference().child('products');
    await dbref.once().then((DataSnapshot snapshot) {
      prodcat = snapshot.value as Map;
      prodcat.values.forEach((element) {
        List<Product> temp = [];
        temp = getEachProductData(element as Map);
        allProducts.addAll(temp);
      });
    });
    return allProducts;
  }

  static Future<List<Product>> getProducts(String type) async {
    DatabaseReference dbref;
    List<Product> product = [];
    switch (type) {
      case 'seeds':
        dbref = FirebaseDatabase.instance.reference().child('products/seeds');
        break;
      case 'pestiside':
        dbref =
            FirebaseDatabase.instance.reference().child('products/pestiside');
        break;
      case 'hardware':
        dbref =
            FirebaseDatabase.instance.reference().child('products/hardware');
        break;
      case 'fertilizer':
        dbref =
            FirebaseDatabase.instance.reference().child('products/fertilizer');
        break;
    }

    await dbref.once().then((DataSnapshot snapshot) {
      product = getEachProductData(snapshot.value as Map);
    });

    return product;
  }

  static List<Product> getEachProductData(Map<dynamic, dynamic> testMap) {
    List<Product> productList = [];
    testMap.forEach((key, value) {
      productList.add(Product(
        productName: value['productname'] ?? "",
        productId: value['productid'] ?? "",
        price: value['price'] ?? "",
        productDesc: value['description'] ?? "",
        rating: value['rating'] ?? "",
      ));
    });
    return productList;
  }
}
