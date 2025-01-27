import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:persistent_shopping_cart_example/main.dart';
import 'package:persistent_shopping_cart_example/res/components/network_image_widget.dart';

class GridTileWidget extends StatelessWidget {
  final PersistentShoppingCartItem data;

  GridTileWidget({super.key, required this.data});

  final PersistentShoppingCart _shoppingCart = PersistentShoppingCart();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NetworkImageWidget(
            borderRadius: 10,
            height: 120,
            width: double.infinity,
            imageUrl: data.productThumbnail ?? '',
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data.productName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              data.productDescription ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              "\$${data.unitPrice.toString()}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _shoppingCart.incrementCartItemQuantity(data.productId);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(50),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.add, size: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        data.quantity.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _shoppingCart.decrementCartItemQuantity(data.productId);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(50),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.remove, size: 18),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 7,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool removed =
                          await _shoppingCart.removeFromCart(data.productId);
                      if (removed) {
                        showSnackBar(navigatorKey.currentContext!, removed);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(0),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(70, 30),
                    ),
                    child: const Text('Remove', style: TextStyle(fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, bool removed) {
    final snackBar = SnackBar(
      content: Text(
        removed
            ? 'Product removed from cart.'
            : 'Product not found in the cart.',
      ),
      backgroundColor: removed ? Colors.green : Colors.red,
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
