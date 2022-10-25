import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_learning_g1/View/Form/formlogin.dart';
import 'package:project_learning_g1/View/News/Newscategories.dart';
import 'package:project_learning_g1/View/News/newsdetail.dart';
import 'package:project_learning_g1/provider/NewsProvider.dart';
import 'package:provider/provider.dart';
import 'package:hidable/hidable.dart';

import '../../provider/NewsProvider.dart';

class NewsPage extends StatefulWidget {
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  var isloading = true;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var newsProvider = Provider.of<NewsProvider>(context);

    if (isloading) {
      (() async {
        await newsProvider.getList();
        setState(() {
          isloading = false;
        });
      })();
    }

    return Scaffold(
        appBar: AppBar(
          title: Align(
            child: Text('News'),
            alignment: Alignment.center,
          ),
        ),
        body: SafeArea(
            child: isloading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: Column(
                      children: [
                        Hidable(
                          controller: scrollController,
                          preferredWidgetSize: Size.fromHeight(85),
                          child: Container(
                            margin: EdgeInsets.only(
                                right: 20, left: 20, top: 20, bottom: 3),
                            height: 60,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ...newsProvider.getlistCategory().map((e) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewsCategories(
                                                  categoryid:
                                                      e.CategoryName.toString()
                                                          .toLowerCase(),
                                                )),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Stack(children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.asset(
                                            e.CategoryImage ?? "",
                                            height: 60,
                                            width: 120,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                            height: 60,
                                            width: 120,
                                            alignment: Alignment.center,
                                            child: Text(
                                              e.CategoryName ?? "",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ]),
                                    ),
                                  );
                                }).toList()
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            controller: scrollController,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              ...newsProvider.list.map((e) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              newsdetail(content: e.content)),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 18),
                                    width: double.infinity,
                                    child: SingleChildScrollView(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                e.urlToImage ??
                                                    "https://haycafe.vn/wp-content/uploads/2022/02/Anh-gai-xinh-Viet-Nam.jpg",
                                                width: double.infinity,
                                                height: 200,
                                                fit: BoxFit.cover,
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            e.title ?? "hello",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            e.description ?? "description",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color.fromARGB(
                                                    255, 90, 89, 89)),
                                          )
                                        ],
                                      ),
                                    )),
                                  ),
                                );
                              }).toList()
                            ],
                          ),
                        ),
                      ],
                    ),
                  )));
  }
}
