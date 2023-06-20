import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: "Product 1", price: 10),
    Product(name: "Product 2", price: 20),
    Product(name: "Product 3", price: 30),
    Product(name: "Product 4", price: 17),
    Product(name: "Product 5", price: 11),
    Product(name: "Product 6", price: 15),
    Product(name: "Product 7", price: 25),
    Product(name: "Product 8", price: 30),
    Product(name: "Product 9", price: 12),
    Product(name: "Product 10", price: 34),



  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name, style: TextStyle(color: Colors.red),),
            subtitle: Text('\$${products[index].price.toString()}'),
            trailing: ProductCounter(
              product: products[index],
              onBuyPressed: (product) {
                if (product.counter == 5) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Congratulations!',style: TextStyle(color: Colors.red),),
                        content: Text('You\'ve bought 5 ${product.name}!',style: TextStyle(color: Colors.brown),),
                        actions: [
                          TextButton(
                            child: Text('OK',style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage(products: products)),
          );
        },
      ),
    );
  }
}

class Product {
  String name;
  double price;
  int counter;

  Product({required this.name, required this.price, this.counter = 0});
}

class ProductCounter extends StatefulWidget {
  final Product product;
  final Function(Product) onBuyPressed;

  ProductCounter({required this.product, required this.onBuyPressed});

  @override
  _ProductCounterState createState() => _ProductCounterState();
}

class _ProductCounterState extends State<ProductCounter> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        children: [
          Text('Counter: ${widget.product.counter.toString()}',style: TextStyle(color: Colors.brown)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red
            ),
            onPressed: () {
              setState(() {
                widget.product.counter++;
                widget.onBuyPressed(widget.product);
              });
            },
            child: Text('Buy Now',),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage({required this.products});

  @override
  Widget build(BuildContext context) {
    int totalItems = products.fold(0, (sum, product) => sum + product.counter);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Cart',),
      ),
      body: Center(
        child: Text('Total Items: $totalItems',style: TextStyle(color: Colors.brown)),
      ),
    );
  }
}


