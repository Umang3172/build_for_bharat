import 'package:build_for_bharat/modules/text_inpainting/ui/virtual_try_on_screen.dart';
import 'package:build_for_bharat/utils/gap.dart';
import 'package:build_for_bharat/utils/styles.dart';
import 'package:flutter/material.dart';

class ExpandedCategoriesWdget extends StatelessWidget {
  const ExpandedCategoriesWdget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const VirtualTryOnScreen())),
            child: Text(
              'Virtual Try On',
              style: Styles.tsw300s,
            ),
          ),
          SizedBox(
            width: Gap.xswg,
          ),
          Text(
            'Collections',
            style: Styles.tsw300s,
          ),
          SizedBox(
            width: Gap.xswg,
          ),
          Text(
            'Store',
            style: Styles.tsw300s,
          ),
          SizedBox(
            width: Gap.xswg,
          ),
          Text(
            'Blog',
            style: Styles.tsw300s,
          ),
          SizedBox(
            width: Gap.xswg,
          ),
          Text(
            'Find store',
            style: Styles.tsw300s,
          )
        ],
      ),
    );
  }
}
