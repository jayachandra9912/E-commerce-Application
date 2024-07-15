import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implement checkout logic here
                cart.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Order placed successfully')),
                );
                Navigator.pop(context);
              },
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
