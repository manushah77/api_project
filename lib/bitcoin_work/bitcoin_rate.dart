import 'dart:convert';
import 'package:api_project/bitcoin_work/bitcoin_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BitCoinPage extends StatefulWidget {
  const BitCoinPage({Key? key}) : super(key: key);

  @override
  State<BitCoinPage> createState() => _BitCoinPageState();
}

class _BitCoinPageState extends State<BitCoinPage> {

// get json method

  Future<BitCoinModel> fethData() async {
    BitCoinModel bm;
    String uri = 'https://api.coindesk.com/v1/bpi/currentprice.json';
    http.Response response = await http.get(Uri.parse(uri));
    Map<String, dynamic> jsondecode = json.decode(response.body);
    bm = BitCoinModel.fromJson(jsondecode);
    return bm;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fethData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<BitCoinModel>(
              future: fethData(),
              builder: (context, AsyncSnapshot sp) {
                if (!sp.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final data = sp.data;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      container_main('${data!.time!.updated}',Colors.amber),
                      container_main('${data!.disclaimer}',Colors.amber),
                      Row(
                        children: [
                          Text('EURO'),
                          Expanded(
                              child: container_main('${data!.bpi.eur.rate}',Colors.pink),),
                        ],
                      ),
                      Row(
                        children: [
                          Text('GBP'),
                          Expanded(
                              child: container_main('${data!.bpi.gbp.rate}',Colors.green)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('USD'),
                          Expanded(
                              child: container_main('${data!.bpi.usd.rate}',Colors.blue)),
                        ],
                      )
                    ],
                  ),
                );
              })),
    );
  }

  Container container_main(String text,Color color) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          color: color,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
