import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:persistent_shopping_cart_example/main.dart';
import 'package:persistent_shopping_cart_example/res/components/network_image_widget.dart';

class CartTileWidget extends StatelessWidget {
  final PersistentShoppingCartItem data;

  CartTileWidget({super.key, required this.data});

  final PersistentShoppingCart _shoppingCart = PersistentShoppingCart();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          NetworkImageWidget(
            borderRadius: 10,
            height: 80,
            width: 80,
            imageUrl: data.productThumbnail ?? '',
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.productName,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    data.productDescription.toString(),
                    maxLines: 2,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "\$ ${data.unitPrice}",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () async {
                        bool removed =
                            await _shoppingCart.removeFromCart(data.productId);
                        if (removed) {
                          // Handle successful removal
                          showSnackBar(navigatorKey.currentContext!, removed);
                        } else {
                          // Handle the case where if product was not found in the cart
                        }
                      },
                      child: Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Center(
                          child: Text(
                            'Remove',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  _shoppingCart.incrementCartItemQuantity(data.productId);
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: .2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.add),
                ),
              ),
              Text(
                data.quantity.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              InkWell(
                onTap: () {
                  _shoppingCart.decrementCartItemQuantity(data.productId);
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: .2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.remove),
                ),
              )
            ],
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
