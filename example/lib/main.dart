// exampl's main.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:persistent_shopping_cart_example/view/products/products_view.dart';

void main() async {
  final persistentShoppingCart = PersistentShoppingCart();

  await persistentShoppingCart.init();
  await persistentShoppingCart.registerAdapters();
  await persistentShoppingCart.openCartBox();

  final jsonString =
      await persistentShoppingCart.readJsonFromAsset('../assets/cart.json');
  final jsonData = json.decode(jsonString);

  final cartModel = CartModel.fromJson(jsonData);
  await persistentShoppingCart.addCartToBox(cartModel);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProductsView(),
    );
  }
}
