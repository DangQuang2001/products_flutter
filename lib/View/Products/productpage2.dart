import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:hidable/hidable.dart';
import 'package:project_learning_g1/View/News/news_page.dart';
import 'package:project_learning_g1/View/Products/productcart.dart';
import 'package:project_learning_g1/View/Products/productdetails.dart';
import 'package:project_learning_g1/View/Products/productpage.dart';
import 'package:project_learning_g1/provider/NewsProvider.dart';
import 'package:project_learning_g1/provider/ProductProvider.dart';
import 'package:provider/provider.dart';

class Productpage2 extends StatefulWidget {
  const Productpage2({Key? key}) : super(key: key);

  @override
  State<Productpage2> createState() => _Productpage2State();
}

class _Productpage2State extends State<Productpage2> {
  var isloading = true;
  var category = "TOP";
  List listproduct = [];
  var itemsview = "grid";
  var _formkey = GlobalKey<FormState>();
  double min = 0;
  double max = 0;
  bool increase = false;
  bool decrease = false;
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    if (isloading) {
      (() async {
        await productProvider.getCategories();
        await productProvider.getList();

        setState(() {
          listproduct = productProvider.sortRating();
          isloading = false;
        });
      })();
    }
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.centerLeft,
                  colors: [
                Color.fromARGB(1, 252, 216, 195),
                Color.fromARGB(255, 226, 226, 226)
              ])),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    title(context, productProvider),
                    SizedBox(
                      height: 20,
                    ),
                    search(context, productProvider),
                    SizedBox(
                      height: 30,
                    ),
                    categories(context, productProvider),
                    SizedBox(
                      height: 30,
                    ),
                    isloading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : (category == "TOP"
                            ? itemstop(context, productProvider)
                            : items(context, productProvider)),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                Positioned(
                    bottom: 5,
                    child: isloading
                        ? SizedBox(
                            height: 0,
                          )
                        : menu(context))
              ],
            ),
          ),
        ),
      ),
    );
  }

  title(BuildContext context, productProvider) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "CHOOSE",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("YOUR",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 248, 95, 84)))
                ],
              ),
              SizedBox(height: 1),
              Row(
                children: [
                  Text(
                    "FAVORITE",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("PRODUCTS",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 248, 95, 84)))
                ],
              )
            ],
          ),
          Container(
            width: 50,
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Productcart()),
                    );
                  },
                ),
                productProvider.cart.length == 0
                    ? SizedBox(
                        height: 0,
                      )
                    : Positioned(
                        top: 8.0,
                        left: 25.0,
                        child: Container(
                          height: 20.0,
                          width: 20.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 248, 95, 84),
                          ),
                          child: Center(
                              child: Text(
                            productProvider.cart.length.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  search(BuildContext context, productProvider) {
    return Container(
        child: TextField(
      onChanged: (value) {
        setState(() {
          category = "search";
          listproduct = productProvider.search(value);
        });
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(255, 255, 254, 254),
        hintText: "Search products",
        suffixIcon: Icon(Icons.search),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(width: 0.2, color: Colors.grey),
        ),
      ),
    ));
  }

  categories(BuildContext context, ProductProvider productProvider) {
    return Container(
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
                    } else if (category == "TOP") {
                      await (productProvider.getList());

                      listproduct = productProvider.sortRating();
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
                            e.toString().toUpperCase(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 248, 95, 84)),
                          )
                        : Text(
                            e.toString().toUpperCase(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
              );
            }).toList()
          ],
        ),
      ),
    );
  }

  items(BuildContext context, ProductProvider productProvider) {
    List list = listproduct;
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 34.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              itemsview = "grid";
                            });
                          },
                          icon: itemsview == "grid"
                              ? Icon(Icons.grid_view_outlined,
                                  color: Color.fromARGB(255, 248, 95, 84))
                              : Icon(Icons.grid_view_outlined,
                                  color: Color.fromARGB(255, 97, 97, 97)),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                itemsview = "list";
                              });
                            },
                            icon: itemsview == "list"
                                ? Icon(Icons.list_alt_outlined,
                                    color: Color.fromARGB(255, 248, 95, 84))
                                : Icon(Icons.list_alt_outlined,
                                    color: Color.fromARGB(255, 97, 97, 97)))
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showSimpleModalDialog(context, productProvider);
                          },
                          child: Container(
                            width: 60,
                            height: 30,
                            child: Row(
                              children: [
                                Text(
                                  "Price",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 87, 87, 87)),
                                ),
                                Icon(Icons.filter_alt_outlined,
                                    size: 19,
                                    color: Color.fromARGB(255, 87, 87, 87))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              listproduct = productProvider.sortRating();
                            });
                          },
                          child: Container(
                            width: 70,
                            height: 30,
                            child: Row(
                              children: [
                                Text(
                                  "Rating",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 87, 87, 87)),
                                ),
                                Icon(Icons.filter_alt_outlined,
                                    size: 19,
                                    color: Color.fromARGB(255, 87, 87, 87))
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                  child: itemsview == "grid"
                      ? GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            mainAxisExtent: 230, // the size of item
                            crossAxisSpacing:
                                10, // margin of 10px top and bottom
                            mainAxisSpacing:
                                10, // margin of 10px left and right
                            // the spacing is not applicable on the GridView margins.
                          ),
                          itemCount: list.length,
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetails(list: list[index])));
                              },
                              child: Container(
                                  margin: EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 185, 184, 184)
                                                .withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 9,
                                        offset: Offset(
                                            3, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 5,
                                                bottom: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Center(
                                                  child: Image.network(
                                                    list[index].image,
                                                    width: 100,
                                                    height: 100,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(list[index].title,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      (list[index].rating
                                                              as Map)['rate']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              104,
                                                              103,
                                                              103)),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Icon(
                                                      Icons.star_outlined,
                                                      size: 15,
                                                      color: Color.fromARGB(
                                                          255, 104, 103, 103),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    (list[index].price)
                                                            .toString() +
                                                        ' \$',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 15,
                                                        color: Colors.red))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                productProvider.add(
                                                    list[index], 1);
                                              });
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 248, 95, 84),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  40),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  40),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  40))),
                                              child: Center(
                                                  child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 19,
                                              )),
                                            ),
                                          )),
                                    ],
                                  )),
                            );
                          },
                        )
                      : ListView(
                          children: [
                            ...list.map((e) {
                              return Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  ProductDetails(list: e))));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                    255, 199, 197, 197)
                                                .withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: Offset(3,
                                                2), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Image.network(
                                                e.image.toString(),
                                                width: 60,
                                              ),
                                            ),
                                            Container(
                                              width: 150,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0, top: 5),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      e.title.toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    Text(
                                                      e.category
                                                          .toString()
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 5),
                                                Text(
                                                  "\$" + e.price.toString(),
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 248, 95, 84),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      (e.rating as Map)['rate']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              104,
                                                              103,
                                                              103)),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Icon(
                                                      Icons.star_outlined,
                                                      size: 15,
                                                      color: Color.fromARGB(
                                                          255, 104, 103, 103),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            productProvider.add(e, 1);
                                          });
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 248, 95, 84),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(40),
                                                  bottomLeft:
                                                      Radius.circular(40),
                                                  bottomRight:
                                                      Radius.circular(40))),
                                          child: Center(
                                              child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 19,
                                          )),
                                        ),
                                      ))
                                ],
                              );
                            })
                          ],
                        )),
            ],
          ),
        ),
      ),
    );
  }

  menu(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(color: Color.fromARGB(255, 226, 226, 226)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.home, size: 32, color: Color.fromARGB(255, 248, 95, 84)),
            Icon(Icons.favorite_outline, size: 35, color: Colors.grey),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Productcart()));
              },
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Color.fromARGB(199, 0, 0, 0),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 248, 95, 84).withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            Icon(Icons.notifications_outlined, size: 32, color: Colors.grey),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 248, 95, 84).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(42)),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.asset(
                    'assets/images/103130337_999338717135285_1507870928285828698_n.jpg',
                    width: 33,
                    height: 33,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  itemstop(BuildContext context, ProductProvider productProvider) {
    List list = listproduct;

    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      height: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                    color: Color.fromARGB(255, 248, 95, 84), width: 1.5)),
            width: MediaQuery.of(context).size.width / 2.1,
            height: 350,
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetails(list: list[19])));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: Image.network(
                                list[19].image,
                                width: 125,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              list[19].title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(195, 0, 0, 0)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Color.fromARGB(255, 248, 95, 84),
                                  size: 19,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  list[19].rating['rate'].toString() +
                                      " (" +
                                      list[19].rating['count'].toString() +
                                      " REVIEW)",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Text("\$",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 248, 95, 84))),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  list[19].price.toString() + ".00",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          productProvider.add(list[19], 1);
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 248, 95, 84),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40))),
                        child: Center(
                            child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 19,
                        )),
                      ),
                    ))
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  itemss(list, 9, productProvider),
                  itemss(list, 16, productProvider),
                ]),
          )
        ],
      ),
    );
  }

  itemss(List list, int index, productProvider) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductDetails(list: list[index])));
                  },
                  child: Column(
                    children: [
                      Image.network(
                        list[index].image,
                        width: 80,
                        height: 90,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Center(
                        child: Text(
                          list[index].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "\$ ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 248, 95, 84)),
                          ),
                          Text(
                            list[index].price.toString(),
                            style: TextStyle(fontWeight: FontWeight.w700),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    productProvider.add(list[index], 1);
                  });
                },
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 248, 95, 84),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35))),
                  child: Center(
                      child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 17,
                  )),
                ),
              ))
        ],
      ),
    );
  }

  _showSimpleModalDialog(context, productProvider) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                constraints: BoxConstraints(maxHeight: 200),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Filter by Price",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Price:",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: 90,
                              height: 40,
                              child: TextFormField(
                                cursorHeight: 25,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    hintText: 'min'),
                                validator: (value) {
                                  if (value != "") {
                                    min = double.parse(value!);
                                  } else {
                                    min = 0;
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "To",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: 90,
                              height: 40,
                              child: TextFormField(
                                cursorHeight: 25,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    hintText: 'max'),
                                validator: ((value) {
                                  if (value != "") {
                                    max = double.parse(value!);
                                  } else {
                                    max = 10000000;
                                  }
                                }),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: increase,
                                  onChanged: (bool? value) {
                                    // This is where we update the state when the checkbox is tapped
                                    setState(() {
                                      increase = true;
                                      decrease = false;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Increase",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: decrease,
                                  onChanged: (bool? value) {
                                    // This is where we update the state when the checkbox is tapped
                                    setState(() {
                                      decrease = true;
                                      increase = false;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Decrease",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  setState(() {
                                    listproduct = productProvider.filter(
                                        min, max, increase, decrease);
                                  });
                                  Navigator.pop(context);
                                  reload();
                                } else {}
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 59, 59, 59),
                                  fixedSize: Size(100, 30),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  )),
                              child: Text("Ok")),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  reload() {
    setState(() {});
  }
}
