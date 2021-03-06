import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_university/domain/book.dart';

class BookListModel extends ChangeNotifier {
  final _userCollection = FirebaseFirestore.instance.collection('books');

  List<Book>? books;

  void fetchBookList() async {
    final QuerySnapshot snapshot = await _userCollection.get();

    final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String title = data['title'];
      final String author = data['author'];
      return Book(id, title, author);
    }).toList();

    this.books = books;
    notifyListeners();
  }

  Future delete(Book book) {
    return _userCollection.doc(book.id).delete();
  }
}
