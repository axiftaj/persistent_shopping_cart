// exampl's main.dart
import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:badges/badges.dart' as badges;
import 'package:persistent_shopping_cart_example/product_list_data.dart';
import 'package:persistent_shopping_cart_example/res/components/network_image_widget.dart';
import 'package:persistent_shopping_cart_example/cart_view.dart';

void main() async {
  await PersistentShoppingCart().init();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProductsScreen(),
    ),
  );
}

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextButton.icon(
                onPressed: () {
                  PersistentShoppingCart().clearCart();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Products Screen'),
        actions: [
          PersistentShoppingCart().showCartItemCountWidget(
            cartItemCountWidgetBuilder: (itemCount) => IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartView()),
                );
              },
              icon: badges.Badge(
                badgeContent: Text(itemCount.toString()),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productsList.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                NetworkImageWidget(
                  borderRadius: 10,
                  height: 80,
                  width: 80,
                  imageUrl: productsList[index].productThumbnail!,
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productsList[index].productName),
                    Text(
                      productsList[index].unitPrice.toString(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                const Spacer(),
                PersistentShoppingCart().showAndUpdateCartItemWidget(
                  inCartWidget: Container(
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
                  notInCartWidget: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Center(
                        child: Text(
                          'Add to cart',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ),
                  product: productsList[index],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
