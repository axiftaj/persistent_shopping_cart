import 'package:hive/hive.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';

class Boxes {
  static Box<PersistentShoppingCartItem> getData() =>
      Hive.box<PersistentShoppingCartItem>('cartBox');
}
