import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/controller/services/cart_controller.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart_example/res/components/network_image_widget.dart';

class CartTileWidget extends StatelessWidget {
  final LineItems data;
  CartTileWidget({super.key, required this.data});
  final CartController _cartController = CartController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.05),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          NetworkImageWidget(
              borderRadius: 10,
              height: 80,
              width: 80,
              imageUrl: data.imageUrls![0]),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${data.brand.toString()} ${data.title.toString()}"),
              IntrinsicHeight(
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 14,
                    ),
                    Text(
                      data.rating.toString(),
                    ),
                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 2,
                      indent: 2,
                      endIndent: 2,
                    ),
                    Text(
                      "Stock ${data.stock!.toString()}",
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "${data.unitPrice!.currencyCode.toString()} ${data.unitPrice!.centAmount.toString()}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () async {
                      bool removed = await CartController()
                          .removeProduct(data.productId.toString());
                      if (removed) {
                        // Handle successful removal
                        showSnackBar(context, removed);
                      } else {
                        // Handle the case where the product was not found in the cart
                      }
                    },
                    child: Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.red)),
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
          const Spacer(),
          Column(
            children: [
              InkWell(
                onTap: () {
                  _cartController.incrementQuantity(data.productId ?? '');
                },
                child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.2),
                        borderRadius: BorderRadius.circular(6)),
                    child: const Icon(Icons.add)),
              ),
              Text(
                data.quantity.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              InkWell(
                onTap: () {
                  _cartController.decrementQuantity(data.productId ?? '');
                },
                child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.2),
                        borderRadius: BorderRadius.circular(6)),
                    child: const Icon(Icons.remove)),
              )
            ],
          ),
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, bool removed) {
    final snackBar = SnackBar(
      content: Text(removed
          ? 'Product removed from cart.'
          : 'Product not found in the cart.'),
      backgroundColor: removed ? Colors.green : Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
