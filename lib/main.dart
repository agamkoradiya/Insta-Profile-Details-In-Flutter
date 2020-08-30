import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkable/linkable.dart';

bool isVisibleAllElement = false;
String dpUrl = "";
String posts = "";
String followers = "";
String following = "";
bool isPrivate = false;
bool isVerified = false;
String fullName = "";
String biography = "";
String externalUrl = "";

void main() {
  debugPrint("main");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint("MyAPp");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

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
            externalUrl = _externalUrl;
          });
        }
      } catch (e) {
        print(e);
        print("======================================================");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Enter a valid Username...')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("TopBar");
    return Scaffold(
      body: Body(),
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

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    debugPrint("Body");
    debugPrint("Visibility  ->  " + isVisibleAllElement.toString());
    return SafeArea(
      child: Container(
        child: isVisibleAllElement
            ? ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(80, 10, 80, 30),
                    child: ClipOval(
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(dpUrl),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(children: [
                          Text(
                            "$posts",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text("Posts")
                        ]),
                      ),
                      Expanded(
                        child: Column(children: [
                          Text(
                            "$followers",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text("Followers")
                        ]),
                      ),
                      Expanded(
                        child: Column(children: [
                          Text(
                            "$following",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text("Following")
                        ]),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(children: [
                            isPrivate
                                ? Icon(Icons.check_circle, color: Colors.blue)
                                : Icon(Icons.cancel),
                            Text("Is Private")
                          ]),
                        ),
                        Expanded(
                          child: Column(children: [
                            isVerified
                                ? Icon(Icons.check_circle, color: Colors.blue)
                                : Icon(Icons.cancel),
                            Text("Is Verified")
                          ]),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "$fullName",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "$biography",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Linkable(text: "$externalUrl")))
                ],
              )
            : Text(""),
      ),
    );
  }
}
