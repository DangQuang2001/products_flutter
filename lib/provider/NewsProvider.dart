import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:project_learning_g1/model/Newsmodel.dart';

import '../model/CategoryModel.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsModel> list = [];
  List<NewsModel> list1 = [];
  Future<void> getList() async {
    String apiURL =
        "https://newsapi.org/v2/everything?q=tesla&from=2022-10-13&sortBy=publishedAt&apiKey=d147efb87264431fae326e986fe15ca0";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    var newsListObject = jsonObject['articles'] as List;
    list = newsListObject.map((e) {
      return NewsModel.fromJson(e);
    }).toList();
    notifyListeners();
  }

  Future<void> getListCategories(String categoryid) async {
    String apiURL =
        "https://newsapi.org/v2/everything?q=${categoryid}&from=2022-10-13&sortBy=publishedAt&apiKey=d147efb87264431fae326e986fe15ca0";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    var newsListObject = jsonObject['articles'] as List;
    list1 = newsListObject.map((e) {
      return NewsModel.fromJson(e);
    }).toList();
    notifyListeners();
  }

  //Categories
  List<Category> getlistCategory() {
    List<Category> categories = [];

    categories.add(Category('World', 'assets/images/_DSC2488.JPG'));
    categories.add(Category('VietNam', 'assets/images/_DSC2531.JPG'));
    categories.add(Category('QuangDepTrai', 'assets/images/_DSC2535.JPG'));
    categories.add(Category('GiaLai', 'assets/images/_DSC2537.JPG'));

    return categories;
  }
}
