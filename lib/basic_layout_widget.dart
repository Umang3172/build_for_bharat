import 'package:build_for_bharat/utils/gap.dart';
import 'package:build_for_bharat/utils/screen_util.dart';
import 'package:flutter/material.dart';

class BasicLayoutWidget extends StatelessWidget {
  final Widget leftWidget;
  final Widget rightWidget;
  const BasicLayoutWidget(
      {super.key, required this.leftWidget, required this.rightWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                child: leftWidget,
              ),
            ),
            SizedBox(
              width: Gap.swg,
            ),
            SizedBox(
              width: ScreenUtil.sw * 0.3,
              child: rightWidget,
            )
          ],
        ),
      ),
    );
  }
}
