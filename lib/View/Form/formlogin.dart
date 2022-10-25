import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_learning_g1/View/Form/formregister.dart';
import 'package:project_learning_g1/View/food.dart';
import 'package:http/http.dart' as http;

var isLogin = false;
var isNote = false;
Future<bool> login(String username, String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:3002/api/users/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{'username': username, 'password': password}),
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    isLogin = true;
    return true;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.

    isLogin = false;
    return false;
  }
}

class FormLogin extends StatefulWidget {
  FormLogin({Key? key}) : super(key: key);

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  var _formkey = GlobalKey<FormState>();
  Future<bool>? _futureuser;

  var password = "";
  var username = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formkey,
        child: Container(
          margin: EdgeInsets.only(top: 50),
          width: double.infinity,
          height: 500,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/Untitled-1 copy.png"),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text("Ten dang nhap"),
                      hintText: "Vui long nhap vao",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(25.0),
                        ),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "ga hau";
                    } else if (value.length < 5) {
                      return "Nhap dai len thang ngu";
                    }
                    username = value;
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text("Mat khau"),
                    hintText: "Vui long nhap mat khau",
                    prefixIcon: Icon(Icons.key),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(25.0),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "ga hau";
                    } else if (value.length < 5) {
                      return "Nhap dai len";
                    }
                    password = value;
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() async {
                          await (_futureuser = login(username, password));

                          if (isLogin) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => food()),
                            );
                          } else {
                            setState(() {
                              isNote = true;
                            });
                          }
                        });
                      } else {}
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                        fixedSize: Size(double.maxFinite, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    child: Text("Login")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FormRegister()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                        fixedSize: Size(400, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    child: Text("Register")),
                Text(
                  isNote ? "Dang nhap that bai !!!" : "",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
