import 'package:agrozon/Model/ProductModel.dart';
import 'package:agrozon/Model/UserModel.dart';
import 'package:firebase_database/firebase_database.dart';

import 'Prefs.dart';

class RealtimeDatabase {
  static AppUser user;

  static Future<void> getUser() async {
    user = await Prefs.getUser();
  }

  //to get all the products from database
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

// to get categorywise product list from database
  static Future<List<Product>> getCategoryProducts(String type) async {
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

// to get each product details from product list and build grid
  static Future<List<Product>> getEachProductData(
      Map<dynamic, dynamic> testMap) async {
    List<Product> productList = [];
    testMap.forEach((key, value) {
      productList.add(Product(
        productName: value['productname'] ?? "",
        productId: value['productid'] ?? "",
        price: value['price'] ?? "",
        productDesc: value['description'] ?? "",
        rating: value['rating'] ?? "",
        imageUrl: value['imageUrl'] ?? "",
      ));
    });
    return productList;
  }

// to add user credential to database for maintaining user favouriter list
// cart and personal details
  static Future<void> addUserData(AppUser appuser) async {
    await getUser();
    DatabaseReference dbref;
    dbref = FirebaseDatabase.instance.reference().child('users/${appuser.uid}');
    Map<String, dynamic> usermap = {
      'username': appuser.fullName,
      'phone': appuser.mobile,
      'email': appuser.email,
    };
    dbref.update(usermap);
  }

// to add product in favourite list of user in database
  static Future<bool> addFavtodb({Product product}) async {
    await getUser();
    final favRef = FirebaseDatabase.instance
        .reference()
        .child('users/${user.uid}/favourites/');
    Map<String, dynamic> favProduct = {
      "${product.productName}": {
        'description': product.productDesc,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'productid': product.productId,
        'productname': product.productName,
        'rating': product.rating
      }
    };
    if (user.uid != null) {
      favRef.update(favProduct);
      return true;
    } else {
      print("uid is null");
      return false;
    }
  }

  //to remove given item from favourite list form database
  static Future<bool> removeFavfromdb({String productName}) async {
    await getUser();
    final favRef = FirebaseDatabase.instance
        .reference()
        .child('users/${user.uid}/favourites/');
    print(productName);
    await favRef.child(productName).remove();
    return false;
  }

  // to get current users favourite product list
  static Future<List<Product>> getFavList() async {
    await getUser();
    DatabaseReference favref;
    List<Product> favproducts = [];
    favref = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child('favourites');
    await favref.once().then((DataSnapshot snapshot) async {
      if (snapshot.value != null) {
        List<Product> temp = [];
        temp = await getEachProductData(snapshot.value as Map);
        favproducts.addAll(temp);
      }
    });
    return favproducts;
  }

  static Future<Map<dynamic, dynamic>> getKartList() async {
    await getUser();
    DatabaseReference kartRef;
    Map<dynamic, dynamic> kartMap = {};
    kartRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("kart");
    print(user.uid);
    await kartRef.once().then((DataSnapshot snapshot) {
      if (snapshot != null) {
        kartMap = snapshot.value as Map;
      }
    });

    return kartMap;
  }

  static Future<void> addToKart(String productid) async {
    await getUser();
    DatabaseReference kartRef;

    Map<dynamic, dynamic> kart = {};
    List<dynamic> kartProdList = [];
    kartRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("kart");
    await kartRef.once().then((DataSnapshot snapshot) {
      if (snapshot != null) {
        kart = snapshot.value;
        kartProdList = kart.keys.toList();
      }
    });
    int len = 0;
    if (kartProdList.contains(productid)) {
      len = int.parse(kart[productid].toString());
      len++;
      await kartRef.update({'$productid': '$len'});
    } else {
      await kartRef.update({'$productid': '1'});
    }
  }

  static Future<void> removeFromKart(String productid) async {
    await getUser();
    DatabaseReference kartRef;
    Map<dynamic, dynamic> kart = {};
    List<dynamic> kartProdList = [];
    kartRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("kart");
    await kartRef.once().then((DataSnapshot snapshot) {
      if (snapshot != null) {
        kart = snapshot.value;
        kartProdList = kart.keys.toList();
      }
    });
    int len = 0;
    if (kartProdList.contains(productid)) {
      len = int.parse(kart[productid].toString());
      len--;
      await kartRef.update({'$productid': '$len'});
    } else {
      print("not in kart");
    }
  }

  static Future<void> deleteFromKart(String productid) async {
    await getUser();
    DatabaseReference kartRef;
    kartRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child('${user.uid}')
        .child("kart");
    kartRef.child(productid).remove();
  }
}
