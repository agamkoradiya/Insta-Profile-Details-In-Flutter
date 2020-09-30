import 'package:flutter/material.dart';
import 'package:linkable/linkable.dart';

import 'main.dart';

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
