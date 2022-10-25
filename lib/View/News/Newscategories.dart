import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_learning_g1/View/News/newsdetail.dart';
import 'package:project_learning_g1/provider/NewsProvider.dart';
import 'package:provider/provider.dart';

class NewsCategories extends StatefulWidget {
  final String categoryid;
  NewsCategories({Key? key, required this.categoryid}) : super(key: key);

  @override
  State<NewsCategories> createState() => _NewsCategoriesState();
}

class _NewsCategoriesState extends State<NewsCategories> {
  var isloading = true;

  @override
  Widget build(BuildContext context) {
    var newsProvider = Provider.of<NewsProvider>(context);

    if (isloading) {
      (() async {
        await newsProvider.getListCategories(widget.categoryid);
        setState(() {
          isloading = false;
        });
      })();
    }
    return Scaffold(
        appBar: AppBar(
          title: Align(
            child: Text(widget.categoryid),
            alignment: Alignment.center,
          ),
        ),
        body: SafeArea(
            child: isloading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          ...newsProvider.list1.map((e) {
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
                  )));
  }
}
