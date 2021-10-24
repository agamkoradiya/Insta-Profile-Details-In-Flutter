import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:insta_profile_flutter_app/body.dart';

import 'main.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSearching = false;
  String userName = "";

  void getHttp(String userName, BuildContext context) async {
    isVisibleAllElement = false;
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      print("not connected ");

      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Check Your Network Connection!!!')));
    } else {
      print("I am connected to a network.");

      try {
        Response response =
            await Dio().get("https://www.instagram.com/$userName/?__a=1");

        print(response.statusCode);
        String statusCode = response.statusCode.toString();

        if (statusCode == "200") {
          setState(() {
            isVisibleAllElement = true;

            String _dpUrl = response.data["graphql"]["user"]
                    ["profile_pic_url_hd"]
                .toString();
            String _posts = response.data["graphql"]["user"]
                    ["edge_owner_to_timeline_media"]["count"]
                .toString();
            String _followers = response.data["graphql"]["user"]
                    ["edge_followed_by"]["count"]
                .toString();
            String _following = response.data["graphql"]["user"]["edge_follow"]
                    ["count"]
                .toString();
            bool _isPrivate = response.data["graphql"]["user"]["is_private"];
            bool _isVerified = response.data["graphql"]["user"]["is_verified"];
            String _fullName =
                response.data["graphql"]["user"]["full_name"].toString();
            String _biography =
                response.data["graphql"]["user"]["biography"].toString();
            String _externalUrl =
                response.data["graphql"]["user"]["external_url"].toString();

            print(response.statusMessage);
            print(_biography);
            print(_externalUrl);
            print(_followers);
            print(_following);
            print(_fullName);
            print(_isPrivate);
            print(_isVerified);
            print(_dpUrl);
            print(_posts);

            dpUrl = response.data["graphql"]["user"]["profile_pic_url_hd"];

            posts = _posts;
            followers = _followers;
            following = _following;
            isPrivate = _isPrivate;
            isVerified = _isVerified;
            fullName = _fullName;
            biography = _biography;
            user=userName;
            externalUrl = _externalUrl;
            setState(() {
              isSearching=false;
            });
          });
        }
      } catch (e) {
        print(e);
        // print("======================================================");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Enter a valid Username...')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("TopBar");
    return Scaffold(
      body: isSearching == true
          ? Center(child: CircularProgressIndicator())
          : Body(),
      appBar: AppBar(
        title: !isSearching
            ? Text("Insta Profile Details Finder")
            : Padding(
                padding: const EdgeInsets.all(5.0),
                child: Builder(
                    builder: (context) => TextField(
                        decoration: InputDecoration(
                          hintText: "Enter Your UserName",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        onSubmitted: (userName) {
                          setState(() {
                            this.userName = userName;
                            getHttp(userName, context);
                          });
                        })),
              ),
        actions: [
          IconButton(
            icon: isSearching ? Icon(Icons.cancel) : Icon(Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
          )
        ],
      ),
    );
  }
}
