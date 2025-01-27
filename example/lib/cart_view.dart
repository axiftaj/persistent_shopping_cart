import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:persistent_shopping_cart_example/res/components/cart_grid_tile_widget.dart';
import 'package:persistent_shopping_cart_example/res/components/cart_tile_widget.dart';
import 'package:persistent_shopping_cart_example/res/components/empty_cart_msg_widget.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  bool _isGridView = false; // Toggle between GridView and ListView
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView; // Toggle view mode
              });
            },
            child: Text(_isGridView ? 'View as List' : 'View as Grid'),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Expanded(
                child: PersistentShoppingCart().showCartItems(
                  cartItemsBuilder: (context, cartItems) {
                    if (_isGridView) {
                      return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final data = cartItems[index];
                          return GridTileWidget(data: data);
                        },
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final data = cartItems[index];
                          if (cartItems.isEmpty) {
                            return const EmptyCartMsgWidget();
                          }
                          return CartTileWidget(data: data);
                        },
                      );
                    }
                  },
                ),
              ),
              PersistentShoppingCart().showTotalAmountWidget(
                cartTotalAmountWidgetBuilder: (totalAmount) => Visibility(
                  visible: !(totalAmount == 0.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                          Text(
                            r"$" + totalAmount.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 22),
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            final shoppingCart = PersistentShoppingCart();

                            // Retrieve cart data and total price
                            Map<String, dynamic> cartData =
                                shoppingCart.getCartData();

                            // Extract cart items and total price
                            List<PersistentShoppingCartItem> cartItems =
                                cartData['cartItems'];
                            double totalPrice = cartData['totalPrice'];

                            /* since cart items is a list, you can run a loop to extract all the values
                                  send it to api or firebase based on your requirement

                             */

                            log('Total Price: $totalPrice');
                          },
                          child: const Text('Checkout'))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
