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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: '本のタイトル',
                    ),
                    onChanged: (text) {
                      model.title = text;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '本の著者',
                    ),
                    onChanged: (text) {
                      model.author = text;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await model.addBook();
                          final snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('本を追加しました'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } catch (e) {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text('追加する'))
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
