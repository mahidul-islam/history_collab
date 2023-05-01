import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  DatabaseReference? _database;
  DatabaseReference? _index;
  DatabaseReference? _details;

  RxMap<String, dynamic> map = {'Zihan': 'vai'}.obs;

  @override
  void onInit() {
    FirebaseDatabase.instance.databaseURL =
        'https://history-collab-default-rtdb.asia-southeast1.firebasedatabase.app/';
    _database = FirebaseDatabase.instance.ref();
    _index = _database?.child('sirah/index/');
    _details = _database?.child('sirah/details/');
    _index?.onValue.listen(
      (DatabaseEvent event) => checkAndUpdate(event),
    );
    super.onInit();
  }

  void checkAndUpdate(DatabaseEvent event) {
    final Map<String, dynamic>? cacheMap =
        json.decode(json.encode(event.snapshot.value));
    map.value = cacheMap ?? {'New': 'default'};
    if (kDebugMode) {
      print(cacheMap);
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
