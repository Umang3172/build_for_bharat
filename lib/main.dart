import 'package:build_for_bharat/modules/home/ui/home_screen.dart';
import 'package:build_for_bharat/productProvider.dart';
import 'package:build_for_bharat/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil(context);
    return ChangeNotifierProvider(
        create: (context) => ProductProvider(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ));
  }
}
