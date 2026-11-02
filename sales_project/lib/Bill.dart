import 'Product.dart';

class Bill {
  bool? type;
  DateTime? dateTime;
  List<Product>? products;

  void set setType(bool type){
    this.type = type;
  }

  bool? get getType{
    return type;
  }

  void set setDate(DateTime dateTime){
    this.dateTime = dateTime;
  }

  DateTime? get getDate{
    return dateTime;
  }

  void set setProduct(List<Product> products){
    this.products = products;
  }

  List<Product>? get getProduct{
    return products;
  }
}