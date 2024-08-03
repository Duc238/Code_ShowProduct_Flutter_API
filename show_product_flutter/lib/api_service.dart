import 'dart:convert';
import 'package:show_product_flutter/Products.dart';
import 'package:http/http.dart' as http;
class ApiService{
  Future<List<Product>> fetchProducts()async{
    final response=await http.get(Uri.parse("https://localhost:7145/api/Products"));
    if(response.statusCode==200){
      List<dynamic> jsonData=jsonDecode(response.body);
      return jsonData.map((json)=>Product.fromJson(json)).toList();
    }
    else{
      throw Exception("Có lỗi xảy ra");
    }
  }
}