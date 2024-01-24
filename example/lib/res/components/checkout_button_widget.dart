import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart_example/res/components/round_button.dart';

class CheckoutButton extends StatelessWidget {
  final VoidCallback onPress;
  final double totalAmount;

  const CheckoutButton({
    Key? key,
    required this.onPress,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(right: 20, top: 20, bottom: 40, left: 20),
      height: 160,
      width: size.width,
      color: Colors.grey.shade100,
      child: Center(
        child: SizedBox(
          width: size.width / 1.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Total: \$${totalAmount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
              RoundButton(onPress: onPress, title: 'Checkout'),
            ],
          ),
        ),
      ),
    );
  }
}
