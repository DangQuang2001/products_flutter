import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_learning_g1/View/Products/productpage2.dart';
import 'package:project_learning_g1/model/ProductModel.dart';
import 'package:project_learning_g1/provider/ProductProvider.dart';
import 'package:provider/provider.dart';

class Productcart extends StatefulWidget {
  const Productcart({Key? key}) : super(key: key);

  @override
  State<Productcart> createState() => _ProductcartState();
}

class _ProductcartState extends State<Productcart> {
  var _formkey = GlobalKey<FormState>();
  double total = 0;
  double discountt = 0;
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    total = 0;
    for (int i = 0; i < productProvider.cart.length; i++) {
      total = total +
          (productProvider.cart[i].price as double) *
              (productProvider.cart[i].count as int);
    }
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              arrow_back(context, productProvider),
              SizedBox(
                height: 30,
              ),
              content(context, productProvider),
              SizedBox(
                height: 20,
              ),
              discount(context),
              SizedBox(
                height: 40,
              ),
              cost(context),
            ],
          ),
        ),
      )),
    );
  }

  arrow_back(BuildContext context, productProvider) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Productpage2())));
              },
              icon: Icon(
                Icons.arrow_back,
                size: 25,
                color: Color.fromARGB(178, 0, 0, 0),
              )),
          Container(
            width: 50,
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                    size: 28,
                  ),
                  onPressed: () {},
                ),
                Positioned(
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
                          color: Colors.white, fontWeight: FontWeight.w500),
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

  content(BuildContext context, productProvider) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      width: double.infinity,
      constraints: BoxConstraints(
          minHeight: 100,
          minWidth: double.infinity,
          maxHeight: MediaQuery.of(context).size.height / 2.2),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: productProvider.cart.length == 0
            ? Center(
                child: Text(
                  "No products !",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              )
            : Column(
                children: [
                  ...productProvider.cart.map((e) {
                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 70,
                          child: Row(
                            children: [
                              Image.network(
                                e.image.toString(),
                                width: 50,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 120,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        e.name.toString().toUpperCase(),
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                      Text(
                                        e.category.toString().toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 80, 79, 79)),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "\$ ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 248, 95, 84)),
                                          ),
                                          Text(
                                            (e.price * e.count)
                                                .toStringAsFixed(2),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            productProvider.remove(e.id);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.remove_shopping_cart_outlined,
                                          size: 17,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                productProvider.add(
                                                    ProductModel(id: e.id), -1);
                                              });
                                            },
                                            child: Container(
                                                width: 22,
                                                height: 22,
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                  size: 15,
                                                )),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Text(
                                            e.count.toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                productProvider.add(
                                                    ProductModel(id: e.id), 1);
                                              });
                                            },
                                            child: Container(
                                                width: 22,
                                                height: 22,
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 15,
                                                )),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    );
                  })
                ],
              ),
      ),
    );
  }

  discount(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      child: Form(
        key: _formkey,
        child: Stack(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  label: Text("Discount Code"),
                  hintText: "Vui long nhap vao",
                  prefixIcon: Icon(Icons.discount_outlined),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(25.0),
                    ),
                  )),
              validator: (value) {
                if (value.toString().toLowerCase() == "giamgia10k") {
                  discountt = 10;
                } else if (value.toString().toLowerCase() == "giamgia20k") {
                  discountt = 20;
                } else if (value.toString().toLowerCase() == "giamgia30k") {
                  discountt = 30;
                } else {
                  return "Khong co ma giam gia nay!";
                }
              },
            ),
            Positioned(
                top: 5,
                right: 0,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {});
                      } else {}
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 248, 95, 84),
                        fixedSize: Size(80, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        )),
                    child: Text("APPLY")))
          ],
        ),
      ),
    );
  }

  cost(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TOTAL",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 87, 86, 86)),
              ),
              Text(
                "\$ " + total.toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 87, 86, 86)),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "DISCOUNT",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 87, 86, 86)),
              ),
              Text(
                "\$ " + discountt.toString() + ".00",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 87, 86, 86)),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "PAY",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Row(
                children: [
                  Text(
                    "\$",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 248, 95, 84)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    (total - discountt).toStringAsFixed(2),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(200, 0, 0, 0)),
            child: Center(
              child: Text("CHECKOUT",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}
