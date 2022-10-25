import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:project_learning_g1/model/ProductModel.dart';

class Cart {
  int? id;
  String? image;
  String? name;
  String? category;
  double? price;
  int? count;

  Cart(this.id, this.image, this.name, this.category, this.price, this.count);
}

class ProductProvider extends ChangeNotifier {
  List<ProductModel> list = [];
  List list1 = [];

  Future<void> getList() async {
    String apiURL = "https://fakestoreapi.com/products";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    var newsListObject = jsonObject as List;
    list = newsListObject.map((e) {
      return ProductModel.fromJson(e);
    }).toList();

    notifyListeners();
  }

  Future<void> getCategories() async {
    list1 = [];
    String apiURL = "https://fakestoreapi.com/products/categories";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    var newsListObject = jsonObject as List;
    list1.add("TOP");
    list1.add("All");
    list1.addAll(newsListObject);
    notifyListeners();
  }

  Future<void> getList1(String category) async {
    String apiURL = "https://fakestoreapi.com/products/category/$category";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    var newsListObject = jsonObject as List;
    list = newsListObject.map((e) {
      return ProductModel.fromJson(e);
    }).toList();

    notifyListeners();
  }

  List<ProductModel> search(String value) {
    List<ProductModel> list2 = [];
    for (int i = 0; i < list.length; i++) {
      if (list[i].title!.toLowerCase().contains(value.toLowerCase())) {
        list2.add(list[i]);
      }
    }
    return list2;
  }

  List sortRating() {
    List list3 = list;
    // for (int i = 0; i < list.length; i++) {
    //   list3.add(list[i]);
    // }
    list3.sort((a, b) => a.rating['rate'].compareTo(b.rating['rate']));

    return list3;
  }

  List sortPrice() {
    List list3 = list;
    // for (int i = 0; i < list.length; i++) {
    //   list3.add(list[i]);
    // }
    list3.sort((a, b) => a.price.compareTo(b.price));

    return list3;
  }

  List<Cart> cart = [];

  void add(ProductModel list, int count) {
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].id == list.id) {
        cart[i].count = cart[i].count! + count;
        if (cart[i].count! < 0) {
          cart[i].count = 0;
        }
        return null;
      }
    }
    cart.add(Cart(
        list.id, list.image, list.title, list.category, list.price, count));
  }

  void remove(int id) {
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].id == id) {
        cart.remove(cart[i]);
      }
    }
  }

  List filter(double min, double max, bool increase, bool decrease) {
    List list3 = [];
    for (int i = 0; i < list.length; i++) {
      if (min <= (list[i].price as double) &&
          (list[i].price as double) <= max) {
        list3.add(list[i]);
      }
    }
    if (increase) {
      list3.sort((a, b) => a.price.compareTo(b.price));
    }
    if (decrease) {
      list3.sort((b, a) => a.price.compareTo(b.price));
    }

    return list3;
  }
}
