import 'package:build_for_bharat/utils/styles.dart';
import 'package:flutter/material.dart';

class MiddleHeaderTextWidget extends StatelessWidget {
  const MiddleHeaderTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'FashionInsta Inc',
          style: Styles.largeHeaderText,
        )
      ],
    );
  }
}
