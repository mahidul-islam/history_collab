// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:convert';
import 'package:code_text_field/code_text_field.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight/languages/all.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:history_collab/app/modules/home/model/entry.dart';
import 'package:history_collab/app/shared/modal/modal_util.dart';
import '../../../shared/services/user_service.dart';

class ArticleController extends GetxController {
  DatabaseReference? _database;
  DatabaseReference? _details;
  DatabaseReference? _index;
  DatabaseReference? _newDetails;
  // StreamSubscription? subscription;
  // FirebaseRemoteConfig? remoteConfig;
  String? database;

  RxnString link = RxnString();
  final TextEditingController titleController = TextEditingController();
  final CodeController articleController = CodeController(
    text: '',
    language: allLanguages['plaintext'],
    modifiers: [const CloseBlockModifier()],
  );

  final Map<String, TextStyle> styles = vsTheme;
  final Map<String, String> users = {};

  Entry? entry;
  int? index;

  @override
  void onInit() {
    FirebaseDatabase.instance.databaseURL =
        'https://history-collab-default-rtdb.asia-southeast1.firebasedatabase.app/';
    _database = FirebaseDatabase.instance.ref();
    entry = Get.arguments[0] as Entry?;
    index = Get.arguments[1] as int?;
    database = Get.arguments[2] as String?;
    database ??= 'sirah';
    link.value = entry?.article?.split('.').first;

    if (link.value != null) {
      titleController.text = link.value ?? '';
      _details = _database?.child('$database/details/${link.value}');
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
    if (link.value == null) {
      _newDetails =
          _database?.child('$database/details/${titleController.text}');
      _index = _database?.child('$database/index/$index');
      await _newDetails?.get().then((value) {
        if (value.value == null) {
          if (UserService.to.userData.value?.role == 'User') {
            _newDetails?.set(articleController.text);
            entry?.article = titleController.text;
            _index?.set(entry?.toJson());
            Get.back();
          }
        } else {
          ModalUtil()
              .showbasicModal(contents: [const Text('title already exists')]);
        }
      });
      if (UserService.to.userData.value?.role == 'User') {
        _details?.set(articleController.text);
        Get.back();
      }
    } else if (link.value == titleController.text) {
      if (UserService.to.userData.value?.role == 'User') {
        _details?.set(articleController.text);
        Get.back();
      }
    } else {
      ModalUtil()
          .showbasicModal(contents: [const Text('can\'t update title yet')]);
    }
  }
}
