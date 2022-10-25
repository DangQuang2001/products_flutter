import 'dart:html';
import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class food extends StatelessWidget {
  food({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            buildReturn(context),
            SizedBox(
              height: 30,
            ),
            buildTitle(context),
            SizedBox(
              height: 10,
            ),
            buildSubTitle(context),
            SizedBox(
              height: 10,
            ),
            buildImage(context),
            SizedBox(
              height: 30,
            ),
            buildPlaces(context),
            SizedBox(
              height: 20,
            ),
            buildList(context)
          ])),
    ));
  }

  buildReturn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Icon(Icons.arrow_back), Icon(Icons.search)],
    );
  }

  buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Today's Special",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 112, 236, 116),
              boxShadow: [
                BoxShadow(
                  color: Colors.green,
                  offset: Offset(1, 5),

                  // blurRadius: _blurRadius,
                  // spreadRadius: _spreadRadius,
                )
              ]),
          width: 90,
          height: 30,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Icon(Icons.add_shopping_cart), Text("CART")]),
        )
      ],
    );
  }

  buildSubTitle(BuildContext context) {
    return Text(
      "Find out what's cooking today!",
      style: TextStyle(color: Colors.grey, fontSize: 15),
    );
  }

  buildImage(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: 350,
          width: MediaQuery.of(context).size.width * 4 / 8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color.fromARGB(255, 54, 200, 244),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 134, 241, 241),
                  offset: Offset(1, 10),

                  // blurRadius: _blurRadius,
                  // spreadRadius: _spreadRadius,
                )
              ]),
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 30),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/Picture1.png',
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Yosimasa Sushi",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, size: 17, color: Colors.white),
                      Icon(
                        Icons.star,
                        size: 17,
                        color: Colors.white,
                      ),
                      Icon(Icons.star, size: 17, color: Colors.white),
                      Icon(Icons.star, size: 17, color: Colors.white),
                      Icon(Icons.star, size: 17, color: Colors.white),
                      Text(
                        "250 Ratings",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Lorem ipsum is a dummy text used for printing",
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  )
                ]),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 3 / 8,
          height: 350,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 165,
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(255, 112, 236, 116),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 134, 241, 241),
                          offset: Offset(1, 10),

                          // blurRadius: _blurRadius,
                          // spreadRadius: _spreadRadius,
                        )
                      ]),
                  child: child1("assets/images/Picture2.png", "Yoshima Sushi"),
                ),
                Container(
                  height: 165,
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(255, 3, 12, 4),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 78, 83, 83),
                          offset: Offset(1, 10),

                          // blurRadius: _blurRadius,
                          // spreadRadius: _spreadRadius,
                        )
                      ]),
                  child: child1("assets/images/Picture3.png", "Prato Sushi"),
                )
              ]),
        )
      ]),
    );
  }

  buildPlaces(BuildContext context) {
    return Container(
      height: 30,
      width: double.infinity,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          "Places",
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 20,
          width: 250,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
        )
      ]),
    );
  }

  buildList(BuildContext context) {
    return Expanded(
        child: ListView(
      scrollDirection: Axis.vertical,
      children: [
        Column(
          children: [
            item("assets/images/Picture4.png", "Sushi Den"),
            SizedBox(
              height: 10,
            ),
            item("assets/images/Picture5.png", "Hatsuhana Sushi"),
            SizedBox(
              height: 10,
            ),
            item("assets/images/Picture6.png", "Quang dep trai"),
          ],
        )
      ],
    ));
  }

  child1(image, name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(image),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        Row(
          children: [
            Icon(
              Icons.star,
              size: 17,
              color: Colors.white,
            ),
            Icon(
              Icons.star,
              size: 17,
              color: Colors.white,
            ),
            Icon(
              Icons.star,
              size: 17,
              color: Colors.white,
            ),
            Icon(
              Icons.star,
              size: 17,
              color: Colors.white,
            ),
            Icon(
              Icons.star,
              size: 17,
              color: Colors.white,
            ),
          ],
        )
      ],
    );
  }

  item(String image, String name) {
    return Container(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
            ),
            Container(
              height: double.infinity,
              width: 170,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(
                      children: [
                        for (var i = 0; i < 5; i++)
                          Icon(
                            Icons.star,
                            size: 17,
                            color: Colors.amber,
                          ),
                      ],
                    ),
                    Text("Lorem ipsum sits dolar amet is for publishing")
                  ],
                ),
              ),
            ),
            Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color.fromARGB(255, 112, 236, 116),
              ),
              child: Center(
                  child: Text(
                "Order Now",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )),
            )
          ],
        ));
  }
}
