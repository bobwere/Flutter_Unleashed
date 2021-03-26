import 'package:flutter/material.dart';
import 'package:flutter_unleashed/common/flutter_unleashed_theme.dart';
import 'package:loading_indicator/loading_indicator.dart';

class BallChasingLoadingIndicator extends StatelessWidget {
  const BallChasingLoadingIndicator(
      {Key key, @required this.width, @required this.height})
      : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: LoadingIndicator(
        indicatorType: Indicator.ballRotateChase,
        color: flutterUnleashedTheme.primaryColor,
      ),
    );
  }
}
