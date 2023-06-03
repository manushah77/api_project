import 'package:api_project/api_home.dart';
import 'package:api_project/bitcoin_work/bitcoin_model.dart';
import 'package:api_project/bitcoin_work/bitcoin_rate.dart';
import 'package:api_project/post_work/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ApiHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
