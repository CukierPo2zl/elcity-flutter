import 'package:elcity/models/spots.dart';
import 'package:elcity/widgets/spot_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';

class SpotWidget extends StatelessWidget {
  final Spot spot;
  final bool owner;
  const SpotWidget({Key key, @required this.spot, this.owner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: (){
        if(owner){
          return spot.id;
        }
        return 'my'+ spot.id.toString();
      },
      child: Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: <Widget>[
                          Chip(
                            avatar: CircleAvatar(
                              radius: 32.0,
                              child: Icon(
                                spot.user.image,
                                color: Colors.white60,
                              ),
                              backgroundColor: Colors.grey,
                            ),
                            label: Text(spot.user.toString()),
                          ),
                          SizedBox(width: 5.0),
                          Chip(
                            avatar: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 32.0,
                              child: Icon(
                                Icons.star,
                                color: Colors.grey,
                              ),
                            ),
                            label: Text('761'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.more_horiz)
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 3.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 300.0,
                        height: 90.0,
                        child: Text(spot.content),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              left: 0.0,
              top: 0.0,
              bottom: 0.0,
              right: 0.0,
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: SpotDetail(spot),
                          type: PageTransitionType.scale,
                          alignment: Alignment.center));
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
