import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreem extends StatelessWidget {
  const CartScreem({Key key}) : super(key: key);
  static const routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Your Card")),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      cart.totalAmount.toStringAsFixed(2),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    backgroundColor: Colors.purple,
                  ),
                  FlatButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                            cart.items.values.toList(), cart.totalAmount);
                        cart.clear();
                      },
                      child: Text("ORDER NOW"))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, i) {
                return CustomCartItem(
                    id: cart.items.values.toList()[i].id,
                    title: cart.items.values.toList()[i].title,
                    price: cart.items.values.toList()[i].price,
                    quantity: cart.items.values.toList()[i].quantity);
              },
            ),
          )
        ],
      ),
    );
  }
}
