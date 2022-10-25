import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class GenreSlider extends StatefulWidget {
  GenreSlider({Key? key}) : super(key: key);

  @override
  State<GenreSlider> createState() => _GenreSliderState();
}

class _GenreSliderState extends State<GenreSlider> {
  List<String> _list = [
    "Anh gai xinh",
    "Anh ba gia",
    "Do an",
    "Shoppee",
    "Lazada",
    "Tikii",
    "Hau cho dien"
  ];

  String genreSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ..._list.map((e) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      genreSelected = e;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(e),
                    width: 100,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color:
                            (genreSelected == e ? Colors.white : Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                  ),
                );
              })
            ],
          )),
    );
  }
}
