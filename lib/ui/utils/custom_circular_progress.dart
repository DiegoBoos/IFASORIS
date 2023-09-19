import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({super.key, required this.alignment});
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: alignment,
        child: SpinKitCircle(
          color: Colors.blue[900],
          size: 100.0,
        ));
  }
}
