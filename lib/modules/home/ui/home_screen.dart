import 'package:build_for_bharat/basic_layout_widget.dart';
import 'package:build_for_bharat/modules/home/ui/chatbot_widget.dart';
import 'package:build_for_bharat/modules/home/ui/widgets/home_screen_left_widget.dart';
import 'package:build_for_bharat/utils/gap.dart';
import 'package:build_for_bharat/utils/screen_util.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // print('hello again');
    return BasicLayoutWidget(
      leftWidget: const HomeScreenLeftWidget(),
      rightWidget: ChatPage(isProduct: false),
    );
  }
}
