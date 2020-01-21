import 'package:elcity/blocs/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: new Container(
                  color: Colors.yellow,
                  child: Center(
                      child: RaisedButton(
                    child: Text('logout'),
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(LoggedOut());
                    },
                  ))),
      ),
    );
  }
}