import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_project/SupabaseHelper.dart';

import 'Customer.dart';

class CustomerPage extends StatefulWidget{

  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage>{

  TextEditingController name_customer = TextEditingController();
  TextEditingController paid = TextEditingController();
  Supabasehelper sbh = Supabasehelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('New Purchasing Bill')
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: sbh.getCustomers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final customers = snapshot.data ?? [];

          return Expanded(
            child: ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];

                return Card(
                  child: Column(
                    children: [
                      Text(customer['name']),
                      Text(customer['paid'].toString()),
                      Text(customer['remaining'].toString()),
                      Text(customer['total'].toString()),
                      Row(
                        children: [
                          ElevatedButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ShowBills(customer['name']))
                            );
                          }, child: Text('Show Bills')),
                          ElevatedButton(onPressed: (){
                            sbh.deleteCustomer(customer['name']);
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
                                        controller: name_customer,
                                        decoration: InputDecoration(
                                            hintText: 'Name of Customer',
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(15)
                                            )
                                        ),
                                      ),
                                      TextField(
                                        controller: paid,
                                        keyboardType: TextInputType.number, // Opens the numeric keyboard
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly, // Limits input strictly to 0-9
                                        ],
                                        decoration: InputDecoration(
                                            hintText: 'Paid',
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
                                      Customer new_customer = Customer();
                                      new_customer.name = name_customer.text;
                                      new_customer.paid = int.parse(paid.text);
                                      sbh.updateCustomer(new_customer, customer['name']);
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