import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_learning_g1/View/Form/formlogin.dart';

var isRegister = false;
int note = 0;
Future<bool> createUser(
    String name, String email, String username, String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:3002/api/users/create'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'username': username,
      'password': password
    }),
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    isRegister = true;
    return true;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    isRegister = false;
    return false;
  }
}

class User {
  final int id;
  final String username;
  final String password;

  const User(
      {required this.id, required this.username, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'], username: json['username'], password: json['password']);
  }
}

class FormRegister extends StatefulWidget {
  FormRegister({Key? key}) : super(key: key);

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  var _formkey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  Future<bool>? _futureuser;
  var name = "";
  var email = "";
  var password = "";
  var username = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formkey,
        child: Container(
          width: double.infinity,
          height: 650,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/Untitled-1 copy.png"),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text("Name"),
                      hintText: "Vui long nhap vao",
                      prefixIcon: Icon(Icons.person_add),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(25.0),
                        ),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Khong duoc de trong";
                    } else if (value.length < 5) {
                      return "It nhat phai 6 ky tu";
                    }
                    name = value;

                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text("Email"),
                      hintText: "Vui long nhap vao",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(25.0),
                        ),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Khong duoc de trong";
                    } else if (value.length < 5) {
                      return "It nhat phai 6 ky tu";
                    }
                    email = value;
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text("Username"),
                      hintText: "Vui long nhap vao",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(25.0),
                        ),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Khong duoc de trong";
                    } else if (value.length < 5) {
                      return "It nhat phai 6 ky tu";
                    }
                    username = value;
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      label: Text("Password"),
                      hintText: "Vui long nhap mat khau",
                      prefixIcon: Icon(Icons.key),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(25.0),
                        ),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Khong duoc de trong";
                    } else if (value.length < 5) {
                      return "It nhat phai 6 ky tu";
                    }
                    password = value;
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      label: Text("Nhap lai Mat khau"),
                      hintText: "Vui long nhap mat khau",
                      prefixIcon: Icon(Icons.key),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(25.0),
                        ),
                      )),
                  validator: (value) {
                    if (value != password) {
                      return "Nhap lai sai mat khau";
                    } else if (value == null || value.isEmpty) {
                      return "khong dc de trong";
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => FormLogin()),
                        // );
                        setState(() async {
                          await (_futureuser =
                              createUser(name, email, username, password));
                          if (isRegister) {
                            setState(() {
                              note = 1;
                            });
                          } else {
                            setState(() {
                              note = 2;
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
                    child: Text("Dang ky")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FormLogin()),
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
                    child: Text("Quay lai")),
                Text(
                  note == 1
                      ? "Dang ky thanh cong"
                      : note == 2
                          ? "Email va tai khoan da bi trung"
                          : "",
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
