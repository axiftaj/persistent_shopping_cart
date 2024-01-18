import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:persistent_shopping_cart/controller/services/boxes.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:persistent_shopping_cart_example/res/components/network_image_widget.dart';
import 'package:persistent_shopping_cart_example/view/cart/cart_view.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  List<LineItems> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      final jsonString = await PersistentShoppingCart()
          .readJsonFromAsset('../assets/products_list.json');
      final jsonData = json.decode(jsonString);

      List<LineItems> productList = List.from(jsonData)
          .map((productJson) => LineItems.fromJson(productJson))
          .toList();

      setState(() {
        products = productList;
      });
    } catch (e) {
      // Handle errors
      print('Error loading products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    log('build');
    return Scaffold(
      drawer: Drawer(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextButton.icon(
                onPressed: () async {
                  await Boxes.getData().clear();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout')),
          )
        ],
      )),
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
      body: products.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
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
                          imageUrl: products[index].imageUrls![0]),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${products[index].brand.toString()} ${products[index].title.toString()}"),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 14,
                                ),
                                Text(
                                  products[index].rating.toString(),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 2,
                                  indent: 2,
                                  endIndent: 2,
                                ),
                                Text(
                                  "Stock ${products[index].stock!.toString()}",
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${products[index].unitPrice!.currencyCode.toString()} ${products[index].unitPrice!.centAmount.toString()}",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                      const Spacer(),
                      PersistentShoppingCart().showAndUpdateCartItemWidget(
                        inCartWidget: Icon(Icons.shopping_bag_rounded),
                        notInCartWidget: Icon(Icons.shopping_bag_outlined),
                        product: products[index],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
