import 'package:elcity/models/spots.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SpotWidget extends StatelessWidget {
  final Spot spot;

  const SpotWidget({Key key, @required this.spot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${spot.user}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(spot.content),
      isThreeLine: true,
      subtitle: Text(spot.content),
      dense: true,
    );
  }
}