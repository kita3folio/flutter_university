import 'package:flutter/material.dart';
import 'package:flutter_university/book_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoolListSample',
      home: BookListPage(),
    );
  }
}
