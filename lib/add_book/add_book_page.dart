import 'package:flutter/material.dart';
import 'package:flutter_university/add_book/add_book_model.dart';
import 'package:flutter_university/domain/book.dart';
import 'package:provider/provider.dart';

class AddBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本を追加'),
        ),
        body: Center(
          child: Consumer<AddBookModel>(builder: (contex, model, child) {
            return Text("本を追加");
          }),
        ),
      ),
    );
  }
}
