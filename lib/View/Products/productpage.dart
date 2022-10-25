import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:project_learning_g1/View/News/news_page.dart';
import 'package:project_learning_g1/provider/NewsProvider.dart';
import 'package:project_learning_g1/provider/ProductProvider.dart';
import 'package:provider/provider.dart';

class Productpage extends StatefulWidget {
  const Productpage({Key? key}) : super(key: key);

  @override
  State<Productpage> createState() => _ProductpageState();
}

class _ProductpageState extends State<Productpage> {
  var isloading = true;
  var category = "All";
  List listproduct = [];
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);

    if (isloading) {
      (() async {
        await productProvider.getCategories();
        await productProvider.getList();
        setState(() {
          listproduct = productProvider.list;
          isloading = false;
        });
      })();
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Menu(context),
              SizedBox(
                height: 10,
              ),
              Titles(context),
              SizedBox(
                height: 20,
              ),
              Search(context, productProvider),
              SizedBox(
                height: 30,
              ),
              Categories(context, productProvider),
              SizedBox(
                height: 10,
              ),
              Items(context, productProvider),
            ],
          ),
        ),
      ),
    );
  }

  Menu(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsPage()),
              );
            },
            icon: Icon(Icons.menu),
            iconSize: 27,
          ),
          Text(
            "Welcome",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'assets/images/103130337_999338717135285_1507870928285828698_n.jpg',
              width: 35,
              height: 35,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }

  Titles(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Choose",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Your",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            children: [
              Text("Favorite",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              SizedBox(
                width: 5,
              ),
              Text(
                "Product",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }

  Search(BuildContext context, productProvider) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: TextField(
        onChanged: (value) {
          setState(() {
            listproduct = productProvider.search(value);
          });
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 241, 240, 240),
          hintText: "Search products",
          suffixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Categories(BuildContext context, productProvider) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Categories",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...productProvider.list1.map((e) {
                    return GestureDetector(
                      onTap: () {
                        setState(() async {
                          category = e;
                          if (e == "All") {
                            await (productProvider.getList());
                            listproduct = productProvider.list;
                          } else {
                            await (productProvider.getList1(e));
                            listproduct = productProvider.list;
                          }
                        });
                      },
                      child: Row(
                        children: [
                          category == e
                              ? Text(
                                  e,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green),
                                )
                              : Text(
                                  e,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    );
                  }).toList()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Items(BuildContext context, productProvider) {
    List list = listproduct;

    return isloading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width / 2.3,
                mainAxisExtent: 200, // the size of item
                crossAxisSpacing: 20, // margin of 10px top and bottom
                mainAxisSpacing: 15, // margin of 10px left and right
                // the spacing is not applicable on the GridView margins.
              ),
              itemCount: list.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 230, 228, 228),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.network(
                              list[index].image,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(list[index].title,
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 5,
                          ),
                          Text((list[index].price).toString() + 'Dola',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16))
                        ],
                      )),
                );
              },
            ),
          );
  }
}
