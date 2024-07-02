import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:history_collab/app/modules/home/model/entry.dart';

class HomeController extends GetxController {
  DatabaseReference? _database;
  DatabaseReference? _index;
  DatabaseReference? _details;
  String? database;
  RxMap<String, dynamic> map = {'Zihan': 'vai'}.obs;
  ScrollController scrollController = ScrollController();

  List<String> tableHeads = <String>[
    'Label',
    'Date',
    'Start',
    'End',
    'Article',
    'Edit',
  ];

  RxList<Entry> entries = RxList.empty();

  @override
  void onInit() {
    database = Get.arguments as String?;
    database ??= 'sirah';
    FirebaseDatabase.instance.databaseURL =
        'https://history-collab-default-rtdb.asia-southeast1.firebasedatabase.app/';
    _database = FirebaseDatabase.instance.ref();
    _index = _database?.child('$database/index/');
    _details = _database?.child('$database/details/');
    _index?.onValue.listen(
      (DatabaseEvent event) => checkAndUpdate(event),
    );
    super.onInit();
  }

  void checkAndUpdate(DatabaseEvent event) {
    if (event.snapshot.value != null) {
      entries.clear();
      final List<dynamic> cacheMap =
          json.decode(json.encode(event.snapshot.value));
      for (int i = 0; i < cacheMap.length; i++) {
        entries.add(Entry(
          label: cacheMap[i]['label'],
          article: cacheMap[i]['article'],
          date: cacheMap[i]['date'],
          start: cacheMap[i]['start'],
          end: cacheMap[i]['end'],
        ));
      }
    }
  }

  @override
  void onClose() {
    _database = null;
    _index = null;
    _details = null;
    super.onClose();
  }

  // This was used to add firebase index database from asset.
  Future<void> uploadAllDataList() async {
    final String res = await rootBundle.loadString('assets/topic_list.json');
    final List<dynamic> li = json.decode(res);
    _index?.set(li);
  }

  // This was used to add firebase details database from asset
  // for all article details.
  Future<void> uploadAllDetailsFiles() async {
    String assets = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(assets);
    final articlesInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/articles") && path.contains(".txt"))
        .toList();
    final Map<String, String> detailsMap = {};
    for (int i = 0; i < articlesInAssets.length; i++) {
      String key = articlesInAssets[i].split('/').last.split('.').first;
      String value = await rootBundle.loadString(articlesInAssets[i]);
      Map<String, String> local = {key: value};
      detailsMap.addAll(local);
    }
    _details?.set(detailsMap);
  }
}
