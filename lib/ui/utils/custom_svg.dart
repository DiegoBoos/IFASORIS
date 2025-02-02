import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvg extends StatelessWidget {
  final String title;
  const CustomSvg({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
        const SizedBox(height: 20),
        SvgPicture.asset(
          'assets/svg/undraw_no_data_re_kwbl.svg',
          width: 200,
          height: 200,
        ),
      ],
    );
  }
}
