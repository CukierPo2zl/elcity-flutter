import 'package:elcity/blocs/myspot/myspot.dart';
import 'package:elcity/blocs/myspot/myspot_bloc.dart';
import 'package:elcity/common/common.dart';
import 'package:elcity/widgets/spot_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class MySpotsList extends StatefulWidget {
  @override
  _MySpotsListState createState() => _MySpotsListState();
}

class _MySpotsListState extends State<MySpotsList> 
with AutomaticKeepAliveClientMixin<MySpotsList>
{
  
  MySpotBloc _postBloc;

  @override
  void initState() {
    super.initState();
   
    _postBloc = BlocProvider.of<MySpotBloc>(context);
    
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MySpotBloc, MySpotState>(
      builder: (context, state) {
        if (state is MySpotUninitialized) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MySpotError) {
          return Center(
          
              child: Column(
                children: <Widget>[
                  Text('failed to fetch spots'),
                 RaisedButton(
                    child: Text('try again'),
                    onPressed: () {
                       _postBloc.add(Fetch());
                    },
                  )
                ],
              ),
            
          );
        }
        if (state is MySpotLoaded) {
          if (state.spots.isEmpty) {
            return Center(
              child: Column(
                children: <Widget>[
                  Text('no spots'),
                 RaisedButton(
                    child: Text('try again'),
                    onPressed: () {
                       _postBloc.add(Fetch());
                    },
                  )
                ],
              ),
            );
          }
          super.build(context);
         return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (BuildContext context, int index) { 
                // int numOfExtraW = 1;
                // index = index-numOfExtraW;
                return SpotWidget(spot: state.spots[index], owner: true,);
              },
              itemCount: state.spots.length,
              
            );
        
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  
}




  
