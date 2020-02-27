import 'package:elcity/common/loading_indicator.dart';
import 'package:flutter/widgets.dart';

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(width: 33, height: 70, child: LoadingIndicator()),
      ),
    );
  }
}