import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './design.dart';
import './result.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String data;
  TextEditingController _city = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDesign,
      body: Stack(
        children: <Widget>[
          img,

          //icon
          Padding(
              padding: const EdgeInsets.only(left: 150, top: 25),
              child: RawMaterialButton(
                child: Ink(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 4.0),
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    //This keeps the splash effect within the circle
                    borderRadius: BorderRadius.circular(
                        1000.0), //Something large to ensure a circle
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.location_city,
                        size: 80.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onPressed: () {},
              )),

          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 170.0, left: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      // padding: const EdgeInsets.only(right: 210,left: 40),
                      child: TextField(
                        controller: _city,
                        style: TextStyle(
                            color: Colors.white, decorationColor: Colors.white),
                        strutStyle: StrutStyle(),
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.location_city,
                              color: Colors.white,
                            ),
                            labelText: "Enter City",
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 20),
                            contentPadding: EdgeInsets.symmetric(vertical: 20),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 240.0, right: .1),
                  child: Center(
                    child: SizedBox(
                      height: 50,
                      width: 110,
                      child: RaisedButton(
                        onPressed: () {
                          getJson();
                          showData();
                          var route = MaterialPageRoute(
                              builder: (BuildContext context) => Result(
                                    citytyped: _city.text,
                                    tem: tempWidget(),
                                  ));
                          Navigator.push(context, route);
                        },
                        color: Colors.blue[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<Map> getJson() async {
    String url =
        'http://api.openweathermap.org/data/2.5/weather?q=${_city.text}&APPID=8126af4e2e2e5e62597a9dc62f7fefc5&units=metric';
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  void showData() async {
    Map data = await getJson();
    print(data.toString());
  }

  Widget tempWidget() {
    return FutureBuilder(
      future: getJson(),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          Map content = snapshot.data;
          return Container(
            child: Stack(
              children: <Widget>[

                
                 Container(
                    height: 340,
                    child: Card(
                      margin: EdgeInsets.only(right: 210,top: 5),
                      elevation: 7.0,
                      child: Center(
                        child: Text("${content["main"]["temp"]}"+"\u02DA"+"C",
                        style: TextStyle(fontSize: 30),),
                      ),
                    ),
                  ),
                


                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10),
                  child: Card(
                      elevation: 10,
                      color: Colors.white,
                      child: Image.asset(
                        "images/humidity.jpg",
                        width: 80,
                      )),
                ),
                Center(
                  child: VerticalDivider(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                Center(
                    child: Divider(
                  color: Colors.white,
                  height: 20,
                ))
              ],
            ),
          );
        } else {
          return Center(
            child: Text(
              "Network Error",
              style: TextStyle(fontSize: 40.0),
            ),
          );
        }
      },
    );
  }
}
