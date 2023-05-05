import 'dart:async';
import 'dart:convert';

import 'package:code_text_field/code_text_field.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight/languages/all.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:history_collab/app/shared/modal/modal_util.dart';

class ArticleController extends GetxController {
  DatabaseReference? _database;
  DatabaseReference? _details;
  StreamSubscription? subscription;
  // RemoteConfigUpdate? remoteConfig;
  FirebaseRemoteConfig? remoteConfig;

  RxnString link = RxnString();
  final TextEditingController _passwordController = TextEditingController();

  final CodeController articleController = CodeController(
    text: '',
    language: allLanguages['plaintext'],
    modifiers: [const CloseBlockModifier()],
  );

  final Map<String, TextStyle> styles = vsTheme;
  final Map<String, String> users = {};

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
    remoteConfig = FirebaseRemoteConfig.instance;
    remoteConfig?.fetchAndActivate();
    super.onInit();
  }

  // void test() {
  //   try {
  //     Map val = jsonDecode(remoteConfig?.getString('users') ?? '');
  //     print(val);
  //   } catch (_) {
  //     print('error');
  //   }
  // }

  void checkAndUpdate(DatabaseEvent event) {
    final String? cacheMap = json.decode(json.encode(event.snapshot.value));
    articleController.text = cacheMap ?? '--';
  }

  void getUpdatedUsers(RemoteConfigUpdate event) {
    print(event.updatedKeys);
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
              final Map<String, String> val = Map<String, String>.from(
                  jsonDecode(remoteConfig?.getString('users') ?? ''));
              if (val.values.contains(_passwordController.text)) {
                // final String name = val.keys.firstWhere(
                //     (element) => val[element] == _passwordController.text);
                // Add name in Database
                // print(name);
                _details?.set(articleController.text);
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
