import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_collab/app/shared/modal/modal_util.dart';

import '../../home/model/entry.dart';

class EntryController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  Entry? entry;
  int? index;

  final TextEditingController _passwordController = TextEditingController();

  DatabaseReference? _database;
  DatabaseReference? _index;
  String? database;

  FirebaseRemoteConfig? remoteConfig;

  @override
  void onInit() {
    entry = Get.arguments[0] as Entry?;
    index = Get.arguments[1] as int?;
    database = Get.arguments[2] as String?;
    database ??= 'sirah';
    nameController.text = entry?.label ?? '';
    dateController.text = entry?.date?.toString() ?? '';
    startController.text = entry?.start?.toString() ?? '';
    endController.text = entry?.end?.toString() ?? '';
    FirebaseDatabase.instance.databaseURL =
        'https://history-collab-default-rtdb.asia-southeast1.firebasedatabase.app/';
    _database = FirebaseDatabase.instance.ref();
    _index = _database?.child('$database/index/${index ?? ''}');
    _index?.onValue.listen(
      (DatabaseEvent event) => checkAndUpdate(event),
    );
    remoteConfig = FirebaseRemoteConfig.instance;
    remoteConfig?.fetchAndActivate();
    super.onInit();
  }

  void checkAndUpdate(DatabaseEvent event) {
    if (event.snapshot.value != null) {
      var cacheMap = json.decode(json.encode(event.snapshot.value));
      Entry entry = Entry.fromJson(cacheMap);
      print(entry.toJson());
    }
  }

  Future<void> save() async {
    ModalUtil().showTwoButtonModal(
      title: 'Editing prev',
      contents: [
        TextField(
          controller: _passwordController,
          obscureText: true,
        ),
        const SizedBox(height: 40),
      ],
      submitOnPressed: () {
        final Map<String, String> val = Map<String, String>.from(
            jsonDecode(remoteConfig?.getString('users') ?? ''));
        if (val.values.contains(_passwordController.text)) {
          entry ??= Entry();
          entry?.label = nameController.text;
          entry?.date = double.tryParse(dateController.text);
          entry?.start = double.tryParse(startController.text);
          entry?.end = double.tryParse(endController.text);

          if (entry?.label != null &&
              ((entry?.start == null &&
                      entry?.end == null &&
                      entry?.date != null) ||
                  (entry?.start != null &&
                      entry?.end != null &&
                      entry?.date == null))) {
            _index?.set(entry?.toJson());
            Get.back();
          } else {
            // print('error');
          }
        }
      },
    );
  }
}
