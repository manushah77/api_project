import 'dart:convert';

import 'package:api_project/bitcoin_work/bitcoin_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

class ApiHome extends StatefulWidget {
  const ApiHome({Key? key}) : super(key: key);

  @override
  State<ApiHome> createState() => _ApiHomeState();
}

class _ApiHomeState extends State<ApiHome> {
  Future<BitCoinModel> fetchData() async {
    BitCoinModel bm;
    String uri = 'https://api.coindesk.com/v1/bpi/currentprice.json';
    http.Response response = await http.get(Uri.parse(uri));
    var decode = json.decode(response.body);
    bm = BitCoinModel.fromJson(decode);
    return bm;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () {
              Share.share('http://schemas.android.com/apk/res/android');
            },
            color: Colors.amber,
            child: Text('Show'),
          ),
        ],
      ),
    );
  }
}
