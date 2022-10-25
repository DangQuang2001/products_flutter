import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Exam2 extends StatefulWidget {
  Exam2({Key? key}) : super(key: key);

  @override
  State<Exam2> createState() => _Exam2State();
}

class _Exam2State extends State<Exam2> {
  List<String> list = [
    'assets/images/_DSC2488.JPG',
    'assets/images/_DSC2531.JPG',
    'assets/images/_DSC2532.JPG',
    'assets/images/_DSC2537.JPG',
  ];

  bool showGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle(context),
            SizedBox(
              height: 20,
            ),
            buildWelcome(context),
            SizedBox(
              height: 20,
            ),
            buildSearch(context),
            SizedBox(
              height: 40,
            ),
            buildSavePlace(context),
            SizedBox(
              height: 10,
            ),
            showGrid ? buildGrid(context) : buildList(context)
          ],
        ),
      )),
    );
  }

  buildTitle(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: Icon(Icons.extension))
        ])
      ]),
    );
  }

  buildWelcome(BuildContext context) {
    return Text.rich(
      TextSpan(
          text: "Welcome,\n",
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
                text: "Charlie",
                style: TextStyle(fontWeight: FontWeight.normal))
          ]),
    );
  }

  buildSearch(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }

  buildSavePlace(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Save Places",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    showGrid = true;
                  });
                },
                icon: Icon(
                  Icons.grid_view_sharp,
                  size: 30,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    showGrid = false;
                  });
                },
                icon: Icon(
                  Icons.list_sharp,
                  size: 30,
                ))
          ],
        )
      ],
    );
  }

  buildGrid(BuildContext context) {
    return Expanded(
        child: GridView.count(
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      crossAxisCount: 2,
      children: [
        ...list.map((e) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image:
                    DecorationImage(image: AssetImage(e), fit: BoxFit.cover)),
          );
        }).toList()
      ],
    ));
  }

  buildList(BuildContext context) {
    return Expanded(
        child: ListView(
      scrollDirection: Axis.vertical,
      children: [
        ...list.map((e) {
          return Container(
            margin: EdgeInsets.only(bottom: 15),
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: AssetImage(e))),
          );
        }).toList()
      ],
    ));
  }
}
