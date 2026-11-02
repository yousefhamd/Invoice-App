import 'package:flutter/foundation.dart';

class Product {
  String? name;
  String? category;
  int? price;
  int? count;

  void set setName(String name){
    this.name = name;
  }

  String? get getName{
    return name;
  }

  void set setCategory(String category){
    this.category = category;
  }

  String? get getCategory{
    return category;
  }

  void set setPrice(int price){
    this.price = price;
  }

  int? get getPrice{
    return price;
  }

  void set setCount(int count){
    this.count = count;
  }

  int? get getCount{
    return count;
  }
}