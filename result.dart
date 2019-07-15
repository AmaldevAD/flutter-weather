import 'dart:convert';


import 'package:flutter/material.dart';
import './design.dart';
import 'package:http/http.dart'as http;


class Result extends StatelessWidget {
  String  citytyped;
  Widget tem;
  Result({Key key,this.citytyped,this.tem}):super(key :key);
  String get name => citytyped;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDesign,

      body: Stack(
        children: <Widget>[
          img,
          tem

        ],

      ),
    );
     

      
  }
}

