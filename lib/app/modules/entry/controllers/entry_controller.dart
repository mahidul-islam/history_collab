import 'dart:convert';

import 'package:code_text_field/code_text_field.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight/languages/all.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:history_collab/app/shared/modal/modal_util.dart';

import '../../home/model/entry.dart';

class EntryController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController articleNameController = TextEditingController();

  Entry? entry;
  int? index;

  final TextEditingController _passwordController = TextEditingController();

  DatabaseReference? _database;
  DatabaseReference? _index;
  DatabaseReference? _details;

  final CodeController articleController = CodeController(
    text: '',
    language: allLanguages['plaintext'],
    modifiers: [const CloseBlockModifier()],
  );

  final Map<String, TextStyle> styles = vsTheme;

  @override
  void onInit() {
    entry = Get.arguments[0] as Entry?;
    index = Get.arguments[1] as int?;
    nameController.text = entry?.label ?? '';
    dateController.text = entry?.date?.toString() ?? '';
    startController.text = entry?.start?.toString() ?? '';
    endController.text = entry?.end?.toString() ?? '';
    articleNameController.text = entry?.article ?? '';
    FirebaseDatabase.instance.databaseURL =
        'https://history-collab-default-rtdb.asia-southeast1.firebasedatabase.app/';
    _database = FirebaseDatabase.instance.ref();
    _index = _database?.child('sirah/index/${index ?? ''}');
    _details = _database
        ?.child('sirah/details/${(entry?.article ?? '').split('.').first}');
    _index?.onValue.listen(
      (DatabaseEvent event) => checkAndUpdate(event),
    );
    _details?.onValue.listen(
      (DatabaseEvent event) => checkAndUpdateDetails(event),
    );
    super.onInit();
  }

  void checkAndUpdate(DatabaseEvent event) {
    var cacheMap = json.decode(json.encode(event.snapshot.value));
    print(cacheMap);
  }

  void checkAndUpdateDetails(DatabaseEvent event) {
    String? cacheMap = json.decode(json.encode(event.snapshot.value));
    articleController.text = cacheMap ?? '';
  }

  Future<void> save() async {
    ModalUtil().showbasicModal(contents: [
      TextField(
        controller: _passwordController,
        obscureText: true,
      ),
      const SizedBox(height: 40),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MaterialButton(
            color: Colors.amberAccent,
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          MaterialButton(
            color: Colors.greenAccent,
            onPressed: () {
              if (_passwordController.text == 'sirah_team') {
                // _index?.set({});
                // _details?.set(articleController.text);
                Get.back();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    ]);
  }
}
