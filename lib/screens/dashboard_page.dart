import 'package:elcity/blocs/spot/spot.dart';
import 'package:elcity/global.dart';
import 'package:elcity/screens/spots_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatelessWidget {
  final pageController = PageController(
    initialPage: 1,
  );
  @override
  Widget build(BuildContext context) {
    return 
        Container(
          color: Colors.grey[100],
          child: BlocProvider(
            create: (context) =>
                SpotBloc(httpClient: http.Client())..add(Fetch()),
            child: SpotsList(),
          ),
        );
  }
}

class SelectLocationView extends StatelessWidget {
  
  const SelectLocationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(onPressed: (){
        Navigator.pop(context);
      }),
    );
  }}