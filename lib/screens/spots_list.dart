import 'package:elcity/blocs/spot/spot.dart';
import 'package:elcity/common/common.dart';
import 'package:elcity/global.dart';
import 'package:elcity/screens/location_page.dart';
import 'package:elcity/widgets/bottom_loader.dart';
import 'package:elcity/widgets/spot_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elcity/screens/dashboard_page.dart';
import 'package:page_transition/page_transition.dart';

class SpotsList extends StatefulWidget {
  @override
  _SpotsListState createState() => _SpotsListState();
}

class _SpotsListState extends State<SpotsList>
    with AutomaticKeepAliveClientMixin<SpotsList> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  SpotBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<SpotBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<SpotBloc, SpotState>(
      builder: (context, state) {
        if (state is SpotUninitialized) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SpotError) {
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
        if (state is SpotLoaded) {
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
          return RefreshIndicator(
            child: ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return SelectLocationW();
                }
                int numOfExtraW = 1;
                index = index - numOfExtraW;
                return index >= state.spots.length
                    ? BottomLoader()
                    : SpotWidget(
                        spot: state.spots[index],
                        owner: false,
                      );
              },
              itemCount: state.hasReachedMax
                  ? state.spots.length + 1
                  : state.spots.length + 2,
              controller: _scrollController,
            ),
            onRefresh: () async {
              _postBloc.add(ForceRefresh());
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    // if (maxScroll - currentScroll <= _scrollThreshold) {
    //   _postBloc.add(Fetch());
    // }
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.offset) {
      _postBloc.add(Fetch());
    }
  }

  @override
  bool get wantKeepAlive => true;
}



class SelectLocationW extends StatelessWidget {
  const SelectLocationW({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.green,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4))
            ),

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.green,
                    ),
                  )),
              Expanded(
                flex: 6,
                child: RaisedButton(onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: SelectLocationView(),
                          type: PageTransitionType.upToDown
                          ));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
