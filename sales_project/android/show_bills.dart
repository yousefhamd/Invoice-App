import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sales_project/Bill.dart';
import 'package:sales_project/SupabaseHelper.dart';

import 'show_products.dart';

class ShowBills extends StatefulWidget{
  final String c_name;

  const ShowBills({super.key, required this.c_name});

  @override
  State<ShowBills> createState() => _ShowBillsState();
}

class _ShowBillsState extends State<ShowBills>{

  DateTime selectedDate = DateTime.now();
  TextEditingController name = TextEditingController();
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
          future: sbh.getCustomerBills(widget.c_name),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            final bills = snapshot.data ?? [];

            return Expanded(
              child: ListView.builder(
                itemCount: bills.length,
                itemBuilder: (context, index) {
                  final bill = bills[index];

                  return Card(
                    child: Column(
                        children: [
                          Text(bill['type']),
                          Text(bill['created_at'].toString()),
                          Row(
                            children: [
                              ElevatedButton(onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ShowProducts(b_id: bill['id']))
                                );
                              }, child: Text('Show Products')),
                              ElevatedButton(onPressed: (){
                                sbh.deleteBill(bill['id']);
                              }, child: Text('Delete')),
                              ElevatedButton(onPressed: (){
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        title: Text('Update Bill'),
                                        content: Row(
                                          children: [
                                            Text('${selectedDate.year} - ${selectedDate.month} - ${selectedDate.day}'),
                                            IconButton(onPressed: () async {
                                              final DateTime? dateTime = await showDatePicker(context: context,
                                                  initialDate: selectedDate,
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(3000));
                                              if (dateTime != null){
                                                setState(() {
                                                  selectedDate = dateTime;
                                                });
                                              }
                                            }, icon: Icon(Icons.calendar_today))
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
                                            Bill new_bill = Bill();
                                            new_bill.type = bill['type'];
                                            new_bill.dateTime = selectedDate;
                                            sbh.updateBill(new_bill, bill['id']);
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