import 'package:agrozon/Core/RealtimeDatabase.dart';
import 'package:agrozon/Model/ProductModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class FavouriteProductProvider extends ChangeNotifier {
  List<Product> favouriteProducts = [];

  List<Product> getFavProduct() {
    return favouriteProducts;
  }

  bool addToFav(Product product) {
    bool result;
    print('here');
    Iterable<Product> p = favouriteProducts
        .where((element) => element.productId == product.productId);
    print(p.length.toString());
    if (p.length < 1) {
      print('product does not exist in favlist and added');
      favouriteProducts.add(product);
      RealtimeDatabase.addFavtodb(productId: product.productId);
      notifyListeners();
      result = true;
    } else {
      print('product does exist in favlist');
      result = false;
    }
    return result;
  }

  bool removeFromFav(String productId) {
    favouriteProducts.removeWhere((element) => element.productId == productId);
    favouriteProducts.join(',');
    return true;
  }
}
