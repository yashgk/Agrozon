import 'package:agrozon/Model/ProductModel.dart';
import 'package:agrozon/Model/UserModel.dart';
import 'package:agrozon/global_variables.dart';
import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabase {
  static Future<List<Product>> getAllProducts() async {
    DatabaseReference dbref;

    final List<Product> allProducts = [];
    Map<dynamic, dynamic> prodcat;
    dbref = FirebaseDatabase.instance.reference().child('products');

    await dbref.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        prodcat = snapshot.value as Map;
        prodcat.values.forEach((element) async {
          List<Product> temp = [];
          temp = await getEachProductData(element as Map);
          allProducts.addAll(temp);
        });
      }
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

    await dbref.once().then((DataSnapshot snapshot) async {
      if (snapshot.value != null) {
        product = await getEachProductData(snapshot.value as Map);
      }
    });
    print(product.length.toString());
    return product;
  }

  static Future<List<Product>> getEachProductData(
      Map<dynamic, dynamic> testMap) async {
    List<Product> productList = [];
    // Map<dynamic, dynamic> favlist = await getFavList();
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

  static Future<void> addUserData(AppUser appuser) async {
    DatabaseReference dbref;
    dbref = FirebaseDatabase.instance.reference().child('users/${appuser.uid}');
    Map usermap = {
      'username': appuser.fullName,
      'phone': appuser.mobile,
      'email': appuser.email,
      'favourites': appuser.favourites
    };
    dbref.set(usermap);
  }

  static void addFavtodb({String productId}) async {
    Map oldfavMap = await getFavList();
    Map newfavMap = {
      '$productId': 'true',
    };
    Map updatedFav;
    final favRef = FirebaseDatabase.instance
        .reference()
        .child('users/${user.uid}/favourites/');

    oldfavMap.addAll(newfavMap ?? {});
    updatedFav = oldfavMap ?? {};
    favRef.set(updatedFav);
  }

  // static Future<Map<dynamic, dynamic>> getAllFavProduct() async {
  //   DatabaseReference dbref;
  //   Map exitstingfav = {};
  //   dbref = FirebaseDatabase.instance
  //       .reference()
  //       .child('users/${user.uid}/favourites/');
  //   await dbref.once().then((DataSnapshot snapshot) {
  //     if (snapshot.value != null) {
  //       exitstingfav = snapshot.value as Map ?? {};
  //     }
  //   });
  //   return exitstingfav;
  // }
   static Future<Map<dynamic, dynamic>> getFavList() async {
    DatabaseReference favref;
    Map favproducts = {};
    favref = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child('favourites');
    await favref.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        favproducts = snapshot.value as Map;
      }
    });
    print(favproducts.length);
    return favproducts;
  }
}
