import 'package:flutter/material.dart';
import 'package:responsi/ui/page_list_matches.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageListMatches(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Name : Syafira Widiyanti
// NIM  : 123200057

