// @dart=2.9
import 'package:flutter/material.dart';
import 'package:project_learning_g1/View/Products/productcart.dart';
import 'package:project_learning_g1/View/Products/productdetails.dart';
import 'package:project_learning_g1/View/Products/productpage2.dart';
import 'package:project_learning_g1/View/exam.dart';
import 'package:project_learning_g1/View/exam2.dart';
import 'package:project_learning_g1/View/food.dart';
import 'package:project_learning_g1/View/Form/formlogin.dart';
import 'package:project_learning_g1/View/Products/productpage.dart';
import 'package:project_learning_g1/View/homepage.dart';
import 'package:project_learning_g1/View/News/news_page.dart';
import 'package:project_learning_g1/provider/NewsProvider.dart';
import 'package:project_learning_g1/View/slideimage.dart';
import 'package:project_learning_g1/provider/ProductProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NewsProvider()),
      ChangeNotifierProvider(create: (context) => ProductProvider()),
    ],
    child: MaterialApp(
      home: Productpage2(),
    ),
  ));
}

//sft
//slt
// flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0