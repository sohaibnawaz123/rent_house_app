import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

late GetIt getIt;

void main() {
  getIt = GetIt.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Housely',
      home: ScreenUtilInit(
        designSize: const Size(402, 871),

        child: const Scaffold(body: Center(child: Text('Hello World'))),
      ),
    );
  }
}
