import 'package:flutter/material.dart';
import 'bill_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BillPage(
                      bill_type: true
                    ),
                  ),
                );
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Purchasing Bill'),
                    Icon(Icons.shopping_cart_checkout)
                  ],
                ),
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BillPage(
                        bill_type: false
                    ),
                  ),
                );
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Selling Bill'),
                    Icon(Icons.sell)
                  ],
                ),
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {

              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Products'),
                    Icon(Icons.trolley)
                  ],
                ),
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {

              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New Customer'),
                    Icon(Icons.settings_accessibility)
                  ],
                ),
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {

              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Customers'),
                    Icon(Icons.group)
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
