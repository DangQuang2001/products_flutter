import 'package:flutter/material.dart';
import 'package:project_learning_g1/model/DestinationModel.dart';

class slideimage extends StatelessWidget {
  slideimage({Key? key}) : super(key: key);

  List<String> _list = [
    'assets/images/_DSC2488.JPG',
    'assets/images/_DSC2531.JPG',
    'assets/images/_DSC2532.JPG',
    'assets/images/_DSC2535.JPG',
    'assets/images/_DSC2537.JPG'
  ];

  List<DestinationModel> _list1 = DestinationModel.MockData();

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: double.infinity,
      height: 400,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            ..._list1.map((e) {
              return Container(
                  child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage(e.image), fit: BoxFit.cover)),
                  ),
                  Text(e.name,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text("Rating:" + e.rating.toString()),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star),
                      Icon(Icons.star)
                    ],
                  )
                ],
              ));
            })
          ])),
    );
  }
}
