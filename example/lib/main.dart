// example's main.dart
import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:persistent_shopping_cart_example/model/item_model.dart';
import 'package:persistent_shopping_cart_example/res/components/network_image_widget.dart';
import 'package:persistent_shopping_cart_example/cart_view.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await PersistentShoppingCart().init();
  runApp(
    MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home:  ProductsScreen(),
    ),
  );
}

class ProductsScreen extends StatelessWidget {
   const ProductsScreen({super.key});

  final List<ItemModel> itemsList = const [
    ItemModel(productId: '1', productName: 'Fried Fish Burger' ,productDescription: 'Served with fries & coleslaw' , productThumbnail: 'https://plus.unsplash.com/premium_photo-1664392182760-b1e2da62b7f7?q=80&w=3139&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D' , unitPrice: 30, ),
    ItemModel(productId: '2' ,productName: 'Loaded Fries' ,productDescription: '200g Premium Loaded Fries' , productThumbnail: 'https://plus.unsplash.com/premium_photo-1683861800944-0ffaf3ef9b13?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D' , unitPrice: 30, ),
    ItemModel(productId: '3',productName: 'Pesto Pasta' ,productDescription: '400g Pesto Pasta' , productThumbnail: 'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D' , unitPrice: 50, ),
    ItemModel(productId: '4',productName: 'Moroccan Fish' ,productDescription: "Fried filet of fish served with Moroccan sauce sided by veggies & choice of side" , productThumbnail: 'https://images.unsplash.com/photo-1492470026006-0e12a33eb7fb?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D' , unitPrice: 20, ),
    ItemModel(productId: '5',productName: 'Creamy Chipotle' ,productDescription: 'Grilled chicken fillet topped with chipotle sauce' , productThumbnail: 'https://images.unsplash.com/photo-1612185533785-cc6f4c55030b?q=80&w=2000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D' , unitPrice: 40, ),
    ItemModel(productId: '6',productName: 'Onion Rings' ,productDescription: '10 imported crumbed onion rings served with chilli garlic sauce' , productThumbnail: 'https://plus.unsplash.com/premium_photo-1701013639121-db90aefda5f2?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D' , unitPrice: 5 ),
    ItemModel(productId: '7',productName: 'Pizza Fries' ,productDescription: 'French fries topped with chicken chunks & pizza sauce with Nachos & cheese' , productThumbnail: 'https://images.unsplash.com/photo-1525518392674-39ba1fca2ec2?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D' , unitPrice: 10, ),
  ] ;

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
        title: const Text('Persistent Shopping Cart' , style: TextStyle(fontSize: 15),),
        centerTitle: true,
        actions: [
          PersistentShoppingCart().showCartItemCountWidget(
            cartItemCountWidgetBuilder: (itemCount) => IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartView()),
                );
              },
              icon: Badge(
                label:Text(itemCount.toString()) ,
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          const SizedBox(width: 20.0)
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView.builder(
              itemCount: itemsList.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              NetworkImageWidget(
                                height: 100,
                                width: 100,
                                imageUrl: itemsList[index].productThumbnail.toString(),
                              ),
                              const SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(itemsList[index].productName ,
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700 , color: Colors.white),
                                    ),
                                    Text(itemsList[index].productDescription ,
                                      maxLines: 2,
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 5,),
                                    Text(r"$"+itemsList[index].unitPrice.toString() ,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: PersistentShoppingCart().showAndUpdateCartItemWidget(
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
                                          width: 100,
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
                                        product: PersistentShoppingCartItem(
                                            productId: index.toString(),
                                            productName: itemsList[index].productName,
                                            productDescription: itemsList[index].productDescription,
                                            unitPrice: double.parse(itemsList[index].unitPrice.toString()),
                                            productThumbnail: itemsList[index].productThumbnail.toString(),
                                            quantity: 2
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
