#persistent_shopping_cart

A Flutter package for managing a persistent shopping cart with advanced features.

Features

Persistent Storage: Utilizes Hive for storing shopping cart data persistently.
Easy Integration: Simplifies the integration of a shopping cart into your Flutter application.
Prebuilt Widgets: Provides prebuilt widgets for common shopping cart UI components.
Item Count Widget: Display the current count of items in the shopping cart.
List Cart Items Widget: Easily list and display cart items with minimal code.
Show and Update Cart Item Widget: Display and update individual cart items effortlessly.

Installation
Add the following line to your pubspec.yaml file:
dependencies:
persistent_shopping_cart: ^1.0.0

flutter pub get

Usage:
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

void main() async {
final cart = PersistentShoppingCart();
await cart.init();
await cart.registerAdapters();
await cart.openCartBox();
}


import 'package:flutter/material.dart';

final cart = PersistentShoppingCart();

void main() {
runApp(
MaterialApp(
home: Scaffold(
appBar: AppBar(
title: const Text('My App'),
actions: [
cart.showCartItemCountWidget(
cartItemCountWidgetBuilder: (itemCount) => IconButton(
onPressed: () {
// Navigate to cart view
},
icon: Badge(
badgeContent: Text(itemCount.toString()),
child: const Icon(Icons.shopping_cart),
),
),
),
],
),
// Your app content
),
),
);
}


Show and Update Cart Item Widget

import 'package:flutter/material.dart';

final cart = PersistentShoppingCart();

void main() {
runApp(
MaterialApp(
home: Scaffold(
body: cart.listCartItems(
cartTileWidget: ({required LineItems data}) => CartTileWidget(data: data),
showEmptyCartMsgWidget: const EmptyCartMsgWidget(),
),
),
),
);
}