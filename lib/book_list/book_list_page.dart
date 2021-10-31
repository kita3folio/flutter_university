import 'package:flutter/material.dart';
import 'package:flutter_university/add_book/add_book_page.dart';
import 'package:flutter_university/edit_book/edit_book_page.dart';
import 'package:flutter_university/book_list/book_list_model.dart';
import 'package:flutter_university/domain/book.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBookList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
          actions: [
            IconButton(
              onPressed: () {
                // 処理を書く.
              },
              icon: Icon(Icons.person),
            ),
          ],
        ),
        body: Center(
          child: Consumer<BookListModel>(builder: (contex, model, child) {
            final List<Book>? books = model.books;

            if (books == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = books
                .map(
                  (book) => Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: ListTile(
                      leading: book.imgURL != null
                          ? Image.network(book.imgURL!)
                          : null,
                      title: Text(book.title),
                      subtitle: Text(book.author),
                    ),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: '編集',
                        color: Colors.black45,
                        icon: Icons.edit,
                        onTap: () async {
                          final String? title = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditBookPage(book),
                            ),
                          );

                          if (title != null) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('$titleを編集しました'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }

                          model.fetchBookList();
                        },
                      ),
                      IconSlideAction(
                        caption: '削除',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () async {
                          await showConfirmDialog(context, book, model);
                        },
                      ),
                    ],
                  ),
                )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton:
            Consumer<BookListModel>(builder: (contex, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true,
                ),
              );

              if (added != null && added) {
                final snackBar = SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('本を追加しました'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              model.fetchBookList();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }

  Future showConfirmDialog(
      BuildContext context, Book book, BookListModel model) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("削除確認"),
          content: Text("『${book.title}』を削除しますか？"),
          actions: [
            TextButton(
              child: Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () async {
                await model.delete(book);

                Navigator.pop(context);

                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('${book.title}を削除しました'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                model.fetchBookList();
              },
            ),
          ],
        );
      },
    );
  }
}
