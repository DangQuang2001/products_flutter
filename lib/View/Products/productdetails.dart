import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_learning_g1/View/Products/productcart.dart';
import 'package:project_learning_g1/View/Products/productpage2.dart';
import 'package:project_learning_g1/model/ProductModel.dart';
import 'package:provider/provider.dart';
import 'package:card_swiper/card_swiper.dart';

import '../../provider/ProductProvider.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel list;
  ProductDetails({Key? key, required this.list}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                arrow_back(context),
                SizedBox(
                  height: 20,
                ),
                title(context),
                SizedBox(
                  height: 30,
                ),
                content(context),
                SizedBox(
                  height: 20,
                ),
                description(context),
                SizedBox(
                  height: 20,
                ),
                cost(context, productProvider),
              ],
            ),
          ),
        ),
      )),
    );
  }

  arrow_back(BuildContext context) {
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
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_outline,
                size: 25,
                color: Colors.grey,
              ))
        ],
      ),
    );
  }

  title(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          widget.list.title.toString().toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            for (int i = 0; i < 5; i++)
              Icon(Icons.star, color: Colors.yellow, size: 18),
            Text((widget.list.rating as Map)['count'].toString() + " REVIEW")
          ],
        )
      ]),
    );
  }

  content(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      padding: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          //                   <--- left side
          color: Color.fromARGB(255, 180, 178, 178),
          width: 0.5,
        )),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TYPE",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.list.category.toString().toUpperCase(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 32, 32, 32)),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "COUNT",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      (widget.list.rating as Map)['count'].toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 32, 32, 32)),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "RATING",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      (widget.list.rating as Map)['rate'].toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 32, 32, 32)),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "COST",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.list.price.toString() + " \$",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 32, 32, 32)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Swiper(
                layout: SwiperLayout.CUSTOM,
                customLayoutOption:
                    CustomLayoutOption(startIndex: -1, stateCount: 3)
                      ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
                      ..addTranslate([
                        Offset(-370.0, -40.0),
                        Offset(0.0, 0.0),
                        Offset(370.0, -40.0)
                      ]),
                itemWidth: 300.0,
                itemHeight: 200.0,
                itemBuilder: (context, index) {
                  return Image.network(widget.list.image.toString());
                },
                itemCount: 3,
                pagination: SwiperPagination(
                    margin: EdgeInsets.only(top: 10),
                    builder: DotSwiperPaginationBuilder(
                        activeColor: Color.fromARGB(255, 245, 93, 82),
                        activeSize: 8,
                        size: 7,
                        color: Colors.grey)),
                // control: SwiperControl(),
              ))
        ],
      ),
    );
  }

  description(BuildContext context) {
    return Container(
      height: 120,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(
          widget.list.description.toString(),
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color.fromARGB(255, 139, 139, 139)),
        ),
      ),
    );
  }

  cost(BuildContext context, productProvider) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "\$",
                    style: TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 248, 95, 84),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    ((widget.list.price as double) * count).toStringAsFixed(2),
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 23),
                  )
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (count == 1) {
                        setState(() {
                          count = 1;
                        });
                      } else {
                        setState(() {
                          count = count - 1;
                        });
                      }
                    },
                    child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 248, 95, 84),
                            borderRadius: BorderRadius.circular(6)),
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    count.toString(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        count = count + 1;
                      });
                    },
                    child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 248, 95, 84),
                            borderRadius: BorderRadius.circular(6)),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              productProvider.add(widget.list, count);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Productcart()));
            },
            child: Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(200, 0, 0, 0)),
              child: Center(
                child: Text("ADD TO CART",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
