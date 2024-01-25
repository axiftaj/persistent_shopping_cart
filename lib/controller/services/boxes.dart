import 'package:hive/hive.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';

/// A utility class providing access to the Hive box for storing cart data.
class Boxes {
  /// Gets the Hive box for storing [PersistentShoppingCartItem] data.
  ///
  /// Returns a [Box] instance for interacting with the cart data stored in Hive.
  static Box<PersistentShoppingCartItem> getData() =>
      Hive.box<PersistentShoppingCartItem>('cartBox');
}
