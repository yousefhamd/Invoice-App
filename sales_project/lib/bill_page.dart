import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_project/Customer.dart';
import 'Bill.dart';
import 'Product.dart';
import 'SupabaseHelper.dart';

class BillPage extends StatefulWidget{
  final bool bill_type;

  const BillPage({super.key, required this.bill_type});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage>{

  DateTime selectedDate = DateTime.now();
  TextEditingController name_product = TextEditingController();
  TextEditingController name_customer = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController count = TextEditingController();
  TextEditingController paid = TextEditingController();
  TextEditingController price = TextEditingController();
  List<Product> products = [];
  Supabasehelper sbh = Supabasehelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Purchasing Bill')
      ),
      body: Column(
        children: [
          Row(
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
          if (widget.bill_type) ...[
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
          ElevatedButton(onPressed: () async {
            Product product = new Product();
            product.name = name_product.text;
            product.category = category.text;
            product.count = int.parse(count.text);
            product.price = int.parse(price.text);
            products.add(product);
            name_product.clear();
            category.clear();
            count.clear();
            price.clear();
          },
              child: Text('Save')
          ),
          ElevatedButton(onPressed: () async {
            Bill bill = new Bill();
            bill.type = widget.bill_type;
            bill.products = products;
            bill.dateTime = selectedDate;
            int bill_id = -1;
            if (widget.bill_type){
              Customer customer = new Customer();
              customer.name = name_customer.text;
              customer.paid = int.parse(paid.text);
              sbh.insertCustomer(customer);
              bill_id = await sbh.newBill(bill, customer.name!);
            }
            else{
              bill_id = await sbh.newBill(bill, 'seller');
            }
            for(Product product in products){
              sbh.insertProduct(product, bill_id);
            }
          }, child: Text('Save Bill'))
        ],
      ),
    );
  }
}