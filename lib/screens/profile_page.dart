import 'package:elcity/blocs/myspot/myspot.dart';
import 'package:elcity/models/user.dart';
import 'package:elcity/resources/user_repository.dart';
import 'package:elcity/screens/myspots_list.dart';
import 'package:elcity/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:elcity/blocs/myspot/myspot.dart';
import 'package:elcity/blocs/authentication/authentication.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ProfileView(),
          Container(
            child: BlocProvider(
                create: (context) =>
                    MySpotBloc(httpClient: http.Client())..add(Fetch()),
                child: MySpotsList()),
          ),
        ],
      ),
    );
  }
}

class ProfileView extends StatefulWidget {
  ProfileView({Key key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with AutomaticKeepAliveClientMixin<ProfileView> {
  UserRepository _userRepository = UserRepository();
  Future<User> _currentUser;

  @override
  void initState() {
    super.initState();

    _currentUser = _userRepository.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Center(
              child: Column(
            children: <Widget>[
              Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.black)
                      ])),
              SizedBox(height: 10.0),
              FutureBuilder<User>(
                future: _currentUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data.username,
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          )),
          RaisedButton(
                    child: Text('logout'),
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(LoggedOut());
                    },
                  )
        ],
        
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
