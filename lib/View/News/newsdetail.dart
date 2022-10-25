import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';

class newsdetail extends StatelessWidget {
  var content;
  newsdetail({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          child: Text('News'),
          alignment: Alignment.center,
        ),
      ),
      body: Html(
          data: content,
          defaultTextStyle: TextStyle(
              fontSize: 15,
              color: Colors.black,
              decoration: TextDecoration.none)),
    );
  }
}
