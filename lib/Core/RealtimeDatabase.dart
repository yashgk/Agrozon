import 'package:agrozon/Model/ProductModel.dart';
import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabase {
  static void getAllProducts() async {
    DatabaseReference dbref =
        FirebaseDatabase.instance.reference().child('products/seeds');

    await dbref.once().then((DataSnapshot snapshot) {
      setData(snapshot.value as Map);
    });
  }

  static setData(Map<dynamic, dynamic> testMap) {
    List<Product> seeds = [];

    testMap.forEach((key, value) {
      // Product product;

      // product.productId = value['productid'] ?? "";
      // product.price = value['price'] ?? "";
      // product.rating = value['rating'] ?? "";
      // product.productDesc = value['description'] ?? "";
      // product.productName = value['productname'] ?? "";
      seeds.add(Product(
        productName: value['productname'] ?? "",
        productId: value['productid'] ?? "",
        price: value['price'] ?? "",
        productDesc: value['description'] ?? "",
        rating: value['rating'] ?? "",
      ));
    });
    print(seeds[2].productName);
  }
}
