import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationView extends StatelessWidget{
  
  const SelectLocationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(onPressed: (){
        Navigator.pop(context);
      }),
      // child: Center(child: Container(
      //   height: 400,
      //   width: MediaQuery.of(context).size.width,
      //   child: GoogleMap(initialCameraPosition: CameraPosition(
      //     target: LatLng(120, -33)
          
      //   )),
      // ),),
    );
  }}