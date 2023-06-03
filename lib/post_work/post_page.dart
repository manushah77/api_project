import 'dart:convert';

import 'package:api_project/post_work/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  UserModel? _userModel;

  TextEditingController nameC = TextEditingController();
  TextEditingController jobC = TextEditingController();

  String uri = 'https://reqres.in/api/users';

  //post json method

  Future<UserModel> postdata(String name, String job) async {
    UserModel? userModel;
    http.Response response =
        await http.post(Uri.parse(uri), body: {"name": name, "Job": job});
    Map<String, dynamic> jsondecode = json.decode(response.body);
    userModel = UserModel.fromJson(jsondecode);
    return userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameC,
            ),
            TextFormField(
              controller: jobC,
            ),
            SizedBox(
              height: 30,
            ),
            _userModel == null
                ? CircularProgressIndicator()
                : Center(child: Text('User Created with name ${_userModel!.name} at date of ${_userModel!.createdAt}')),
            MaterialButton(
              onPressed: () async {
                UserModel user = await postdata(nameC.text, jobC.text);
                setState(() {
                  _userModel = user;
                });
              },
              child: Text('SAVE'),
              color: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }
}
