// persistent_shopping_cart.dart
library persistent_shopping_cart;

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persistent_shopping_cart/controller/cart_controller.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/widgets/cart_list.dart';

extension IterableExtensions<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}

class PersistentShoppingCart {
  // Initialize hive
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    // Register the adapters
    Hive.registerAdapter(PersistentShoppingCartItemAdapter());
    //open cart box
    await Hive.openBox<PersistentShoppingCartItem>('cartBox');
  }

  Future<void> addToCart(PersistentShoppingCartItem cartItem) async {
    CartController().addToCart(cartItem);
    log('CartItem added to Hive box: ${cartItem.toJson()}');
  }

  Future<bool> removeFromCart(String productId) async {
    bool removed = CartController().removeFromCart(productId);
    if (removed) {
      log('CartItem removed from Hive box: $productId');
    } else {
      log('Product not found in the cart: $productId');
    }
    return removed;
  }

  Future<void> incrementCartItemQuantity(String productId) async {
    CartController().incrementQuantity(productId);
    log('CartItem quantity incremented: $productId');
  }

  Future<void> decrementCartItemQuantity(String productId) async {
    CartController().decrementQuantity(productId);
    log('CartItem quantity decremented: $productId');
  }

  double calculateTotalPrice() {
    return CartController().calculateTotalPrice();
  }

  int getCartItemCount() {
    return CartController().getCartItemCount();
  }

  void clearCart() {
    CartController().clearCart();
  }

  Widget showCartItems({
    required Widget Function({required PersistentShoppingCartItem data})
        cartTileWidget,
    required Widget showEmptyCartMsgWidget,
  }) {
    return ListCartItems(
      cartTileWidget: cartTileWidget,
      showEmptyCartMsgWidget: showEmptyCartMsgWidget,
    );
  }

  Widget showCartItemCountWidget(
      {required Widget Function(int itemCount) cartItemCountWidgetBuilder}) {
    return ValueListenableBuilder<Box<PersistentShoppingCartItem>>(
      valueListenable: CartController().cartListenable,
      builder: (context, box, child) {
        var itemCount = CartController().getCartItemCount();
        return cartItemCountWidgetBuilder(itemCount);
      },
    );
  }

  Widget showTotalAmountWidget(
      {required Widget Function(double totalAmount)
          cartTotalAmountWidgetBuilder}) {
    return ValueListenableBuilder<Box<PersistentShoppingCartItem>>(
      valueListenable: CartController().cartListenable,
      builder: (context, box, child) {
        double totalAmount = CartController().getTotalPrice();
        return cartTotalAmountWidgetBuilder(totalAmount);
      },
    );
  }

  Widget showAndUpdateCartItemWidget({
    required Widget inCartWidget,
    required Widget notInCartWidget,
    required PersistentShoppingCartItem product,
  }) {
    return ValueListenableBuilder<Box<PersistentShoppingCartItem>>(
      valueListenable: CartController().cartListenable,
      builder: (context, box, child) {
        bool existsInCart =
            CartController().isItemExistsInCart(product.productId);

        return IconButton(
          onPressed: () async {
            existsInCart
                ? await removeFromCart(product.productId)
                : await addToCart(product);
          },
          icon: existsInCart ? inCartWidget : notInCartWidget,
        );
      },
    );
  }
}
