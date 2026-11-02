import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart' show AllocatorAlloc;

import 'package:sales_project/Product.dart';

import 'Bill.dart';

class Customer {
  String? name;
  int? paid;

  void set setName(String name){
    this.name = name;
  }

  String? get getName{
    return name;
  }

  void set setPaid(int paid){
    this.paid = paid;
  }

  int? get getPaid{
    return paid;
  }

  double calcTotal(List<Bill> bills){
    double result = 0;
    for (Bill bill in bills){
      List<Product>? products = bill.products;
      for (Product product in products!){
        result += product.getCount() * product.price();
      }
    }
    return result;
  }

  double calcRemaining(List<Bill> bills){
    return calcTotal(bills) - paid!;
  }
}