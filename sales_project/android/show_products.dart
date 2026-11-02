import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_project/Product.dart';
import 'package:sales_project/SupabaseHelper.dart';

class ShowProducts extends StatefulWidget{
  final int b_id;

  const ShowProducts({super.key, required this.b_id});

  @override
  State<ShowProducts> createState() => _ShowProductsState();
}

class _ShowProductsState extends State<ShowProducts>{

  DateTime selectedDate = DateTime.now();
  TextEditingController name_product = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController count = TextEditingController();
  TextEditingController price = TextEditingController();
  Supabasehelper sbh = Supabasehelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('New Purchasing Bill')
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: sbh.getBillProducts(widget.b_id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            final products = snapshot.data ?? [];

            return Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  return Card(
                    child: Column(
                        children: [
                          Text(product['name']),
                          Text(product['category']),
                          Text(product['count']),
                          Text(product['price']),
                          Row(
                            children: [
                              ElevatedButton(onPressed: (){
                                sbh.deleteProduct(product['id']);
                              }, child: Text('Delete')),
                              ElevatedButton(onPressed: (){
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        title: Text('Update Customer'),
                                        content: Column(
                                          children: [
                                            TextField(
                                              controller: name_product,
                                              decoration: InputDecoration(
                                                  hintText: 'Name of Product',
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(15)
                                                  )
                                              ),
                                            ),
                                            TextField(
                                              controller: category,
                                              decoration: InputDecoration(
                                                  hintText: 'Category of Product',
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(15)
                                                  )
                                              ),
                                            ),
                                            TextField(
                                              controller: count,
                                              keyboardType: TextInputType.number, // Opens the numeric keyboard
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.digitsOnly, // Limits input strictly to 0-9
                                              ],
                                              decoration: InputDecoration(
                                                  hintText: 'Count of Product',
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(15)
                                                  )
                                              ),
                                            ),
                                            TextField(
                                              controller: price,
                                              keyboardType: TextInputType.number, // Opens the numeric keyboard
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.digitsOnly, // Limits input strictly to 0-9
                                              ],
                                              decoration: InputDecoration(
                                                  hintText: 'Price of Product',
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(15)
                                                  )
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          ElevatedButton(onPressed: (){
                                            Product new_product = Product();
                                            new_product.name = name_product.text;
                                            new_product.category = category.text;
                                            new_product.count = int.parse(count.text);
                                            new_product.price = int.parse(price.text);
                                            sbh.updateProduct(new_product, product['id']);
                                          }, child: const Text('Confirm'))
                                        ],
                                      );
                                    }
                                );
                              }, child: Text('Update'))
                            ],
                          )
                        ]
                    ),
                  );
                },
              ),
            );
          },
        )
    );
  }
}