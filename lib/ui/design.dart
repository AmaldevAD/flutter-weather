import 'package:flutter/material.dart';
import './result.dart';



AppBar appBarDesign = AppBar(
  title: Text("Weather Finder"),
  backgroundColor: Colors.grey[850],
  centerTitle: true,

);


var img=SizedBox.expand(
            child: Image.asset(
              'images/background.png',
              fit: BoxFit.fill,
            ),
          );


         