import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditBookModel extends ChangeNotifier {
  String? title;
  String? author;
  Future updateBook() async {
    if (title == null || title!.isEmpty) {
      throw '本のタイトルが入力されていません';
    }
    if (author == null || author!.isEmpty) {
      throw '本の著者が入力されていません';
    }

    // firestoreに追加
    await FirebaseFirestore.instance.collection('books').add({
      'title': title,
      'author': author,
    });
  }
}
