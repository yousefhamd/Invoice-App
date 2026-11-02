import 'package:sales_project/Bill.dart';
import 'package:sales_project/Product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Customer.dart';

class Supabasehelper {
  final supabase = Supabase.instance.client;

  Future<int> newBill(Bill bill, String c_name) async {
    final data = await supabase
        .from('Bill')
        .insert({'type': bill.type, 'created_at': bill.dateTime, 'c_name': c_name})
        .select('id')
        .single();

    return data['id'];
  }

  Future<void> updateBill(Bill bill, int id) async => await supabase
        .from('Bill')
        .update({'type': bill.type, 'created_at': bill.dateTime})
        .eq('id', id);

  Future<void> insertProduct(Product product, int bill_id) async => await supabase
        .from('Product')
        .insert({'name': product.name, 'category': product.category,
      'count': product.count, 'price': product.price, 'b_id': bill_id});

  Future<List<Map<String, dynamic>>> getCustomerBills(String c_name) async {
    final response = await supabase
        .from('Bill')
        .select()
        .eq('c_name', c_name);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> getBillProducts(int id) async {
    final response = await supabase
        .from('Product')
        .select()
        .eq('b_id', id);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> updateProduct(Product product, int id) async => await supabase
      .from('Product')
      .update({'name': product.name, 'category': product.category, 'count': product.count, 'price': product.price})
      .eq('id', id);

  Future<void> insertCustomer(Customer customer) async => await supabase
      .from('Customer')
      .insert({'name': customer.name, 'paid': customer.paid,
    'remaining': customer.calcRemaining(getCustomerBills(customer.name!) as List<Bill>),
    'total': customer.calcTotal(getCustomerBills(customer.name!) as List<Bill>)});

  Future<Map<String, int>> getProducts() async {
    final data = await supabase
        .from('Product')
        .select('''
      name,
      category,
      count,
      Bill:b_id (
        type
      )
    ''');

    final Map<String, int> stock = {};

    for (final item in data) {
      final key = '${item['name']}_${item['category']}';

      final count = item['count'] as int;
      final billType = item['Bill']['type'];

      if (!stock.containsKey(key)) {
        stock[key] = 0;
      }

      if (billType == true) {
        stock[key] = stock[key]! + count;
      } else if (billType == false) {
        stock[key] = stock[key]! - count;
      }
    }

    return stock;
  }

  Future<List<Map<String, dynamic>>> getCustomers() async {
    final response = await supabase
        .from('Customer')
        .select();

    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> updateCustomer(Customer customer, String old_name) async => await supabase
      .from('Customer')
      .update({'name': customer.name, 'paid': customer.paid,
    'remaining': customer.calcRemaining(getCustomerBills(old_name) as List<Bill>),
    'total': customer.calcTotal(getCustomerBills(old_name) as List<Bill>),})
      .eq('name', old_name);

  Future<void> deleteCustomer(String name) async => await supabase
      .from('Customer')
      .delete()
      .eq('name', name);

  Future<void> deleteBill(int id) async => await supabase
      .from('Bill')
      .delete()
      .eq('id', id);

  Future<void> deleteProduct(int id) async => await supabase
      .from('Product')
      .delete()
      .eq('id', id);

  
}