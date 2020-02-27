import 'package:elcity/global.dart';
import 'package:elcity/models/spots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpotDetail extends StatelessWidget {
  final Spot _spot;
  SpotDetail(this._spot);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
            color: primaryColor, 
          ),
        title:Text(
        _spot.id.toString(),
         style: TextStyle(color: primaryColor),
         ),
         backgroundColor: Colors.white,
         

      ),
      body: Center(
        child: Text(_spot.content),
      ),
    );
  }

  
}