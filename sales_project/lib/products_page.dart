import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SupabaseHelper.dart';

class ShowProductsPage extends StatefulWidget{
  const ShowProductsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ShowProductsPageState();

}

class _ShowProductsPageState extends State<ShowProductsPage>{
  Supabasehelper sbh = Supabasehelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Customers'),
      ),
      body: FutureBuilder<Map<String, int>>(
        future: sbh.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final products = snapshot.data ?? {};

          if (products.isEmpty) {
            return const Center(
              child: Text('No customers found'),
            );
          }

          final entries = products.entries.toList();

          return Expanded(
              child: ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index];

                  final List<String> name_category = entry.key.split('_');
                  final String name = name_category[0];
                  final String category = name_category[1];
                  final int count = entry.value;

                  return Card(
                      child: Column(
                        children: [
                          Text(name),
                          Text(category),
                          Text(count.toString())
                        ],
                      )
                  );
                },
              )
          );
        },
      ),
    );
  }
}