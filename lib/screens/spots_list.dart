import 'package:elcity/blocs/spot/spot.dart';
import 'package:elcity/common/common.dart';
import 'package:elcity/widgets/spot_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpotsList extends StatefulWidget {
  @override
  _SpotsListState createState() => _SpotsListState();
}

class _SpotsListState extends State<SpotsList> {
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
    return BlocBuilder<SpotBloc, SpotState>(
      builder: (context, state) {
        if (state is SpotUninitialized) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SpotError) {
          return Center(
            child: Text('failed to fetch spots'),
          );
        }
        if (state is SpotLoaded) {
          if (state.spots.isEmpty) {
            return Center(
              child: Text('no spots'),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.spots.length
                  ? BottomLoader()
                  : SpotWidget(spot: state.spots[index]);
            },
            itemCount: state.hasReachedMax
                ? state.spots.length
                : state.spots.length + 1,
            controller: _scrollController,
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
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.add(Fetch());
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: LoadingIndicator()
        ),
      ),
    );
  }
}