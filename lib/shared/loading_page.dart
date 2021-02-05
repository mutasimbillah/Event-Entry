import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Center(
        child: SpinKitFadingCircle(
          color: Colors.black,
          size: 100.0,
        ),
      ),
    );
  }
}
