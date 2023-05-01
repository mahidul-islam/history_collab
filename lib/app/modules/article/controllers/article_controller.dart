import 'dart:convert';

import 'package:code_text_field/code_text_field.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight/languages/all.dart';
import 'package:flutter_highlight/themes/vs.dart';

class ArticleController extends GetxController {
  DatabaseReference? _database;
  DatabaseReference? _details;
  RxnString link = RxnString();

  final CodeController articleController = CodeController(
    text: '',
    language: allLanguages['plaintext'],
    modifiers: [const CloseBlockModifier()],
  );

  final Map<String, TextStyle> styles = vsTheme;

  @override
  void onInit() {
    String? arg = Get.arguments as String?;
    link.value = arg?.split('.').first;
    if (link.value != null) {
      FirebaseDatabase.instance.databaseURL =
          'https://history-collab-default-rtdb.asia-southeast1.firebasedatabase.app/';
      _database = FirebaseDatabase.instance.ref();

      _details = _database?.child('sirah/details/${link.value}');
      _details?.onValue.listen(
        (DatabaseEvent event) => checkAndUpdate(event),
      );
    }
    super.onInit();
  }

  void checkAndUpdate(DatabaseEvent event) {
    final String? cacheMap = json.decode(json.encode(event.snapshot.value));
    articleController.text = cacheMap ?? '--';
  }

  Future<void> save() async {
    //
  }
}
